package com.hmdandelion.project_1410002.sales.domain.entity.estimate;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Table(name = "tbl_estimate_product")
@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class EstimateProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long estimateProductCode;
    private Integer quantity;
    private Integer price;
    @ManyToOne
    @JoinColumn(name = "estimate_code")
    private Estimate estimate;
    private Integer productCode;

    public EstimateProduct(Integer quantity, Integer price, Integer productCode) {
        this.quantity = quantity;
        this.price = price;
        this.productCode = productCode;
    }

    public static EstimateProduct of(Integer quantity, Integer price, Integer productCode) {
        return new EstimateProduct(
                quantity,
                price,
                productCode
        );
    }
}
