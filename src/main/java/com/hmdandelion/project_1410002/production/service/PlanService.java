package com.hmdandelion.project_1410002.production.service;

import com.hmdandelion.project_1410002.common.exception.NotFoundException;
import com.hmdandelion.project_1410002.production.domain.entity.ProductionPlan;
import com.hmdandelion.project_1410002.production.domain.repository.ProductionPlanRepo;
import com.hmdandelion.project_1410002.production.dto.request.ProductionPlanCreateRequest;
import com.hmdandelion.project_1410002.production.dto.request.ProductionPlanUpdateRequest;
import com.hmdandelion.project_1410002.production.dto.response.PlanListResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;

import static com.hmdandelion.project_1410002.common.exception.type.ExceptionCode.ALREADY_EXIST_PRODUCTION_PLAN;

@Service
@RequiredArgsConstructor
@Transactional
public class PlanService {

    private final ProductionPlanRepo productionRepository;

    private Pageable getPageable(final Integer page) {
        return PageRequest.of(page - 1, 10, Sort.by("planCode").descending());
    }

    @Transactional(readOnly = true)
    public Page<PlanListResponse> getPlanListBetweenDates(String dt, Integer page) {

        LocalDate startAt = LocalDate.parse(dt + "-01");
        LocalDate endAt = startAt.with(TemporalAdjusters.lastDayOfMonth());

        Page<PlanListResponse> planList = productionRepository.findPlanDetails(getPageable(page), startAt ,endAt);

        return planList;
    }

    public Long planSave(final ProductionPlanCreateRequest productionPlanCreateRequest) {
        final ProductionPlan
                newPlan = ProductionPlan.of(
                productionPlanCreateRequest.getStartAt(),
                productionPlanCreateRequest.getDescription(),
                productionPlanCreateRequest.getEndAt()

        );

        // 새로운 생산 계획의 시작 날짜와 종료 날짜
        LocalDate startAt = productionPlanCreateRequest.getStartAt();
        LocalDate endAt = productionPlanCreateRequest.getEndAt();

        // 해당 날짜와 겹치는 계획이 있는지 확인
        boolean overlappingPlansExist = productionRepository.existsByDateRange(startAt, endAt);
        if (overlappingPlansExist) {
            // 겹치는 계획이 있으면 예외를 발생시킵니다.
            throw new NotFoundException(ALREADY_EXIST_PRODUCTION_PLAN);
        }

        final ProductionPlan plan = productionRepository.save(newPlan);

        return plan.getPlanCode();
    }

    public void planModify(Long planCode, ProductionPlanUpdateRequest productionPlanUpdateRequest) {
        ProductionPlan productionPlan = productionRepository.findByPlanCode(planCode)
                .orElseThrow(() -> new RuntimeException());

        productionPlan.planModify(
                productionPlanUpdateRequest.getStartAt(),
                productionPlanUpdateRequest.getEndAt(),
                productionPlanUpdateRequest.getDescription()
        );
    }

    public void planRemove(Long planCode) {

        productionRepository.deleteById(planCode);
    }
}
