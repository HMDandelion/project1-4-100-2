package com.hmdandelion.project_1410002.sales.presentation;

import com.hmdandelion.project_1410002.common.paging.Pagination;
import com.hmdandelion.project_1410002.common.paging.PagingButtonInfo;
import com.hmdandelion.project_1410002.common.paging.PagingResponse;
import com.hmdandelion.project_1410002.sales.dto.request.ClientCreateRequest;
import com.hmdandelion.project_1410002.sales.dto.request.ClientUpdateRequest;
import com.hmdandelion.project_1410002.sales.dto.response.SalesClientResponse;
import com.hmdandelion.project_1410002.sales.dto.response.SalesClientsResponse;
import com.hmdandelion.project_1410002.sales.model.ClientType;
import com.hmdandelion.project_1410002.sales.service.ClientService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1")
public class ClientController {

    private final ClientService clientService;

    @GetMapping("/clients")
    public ResponseEntity<PagingResponse> getSalesClients(
            @RequestParam(defaultValue = "1") final Integer page,
            @RequestParam(required = false) final String sort,
            @RequestParam(required = false) final String clientName,
            @RequestParam(required = false) final Boolean isOrdered
    ) {
        System.out.println("sort: " + sort);
        System.out.println("clientName: " + clientName);
        System.out.println("isOrdered: " + isOrdered);

        final Page<SalesClientsResponse> clients = clientService.getSalesClients(page, sort, clientName, isOrdered);
        final PagingButtonInfo pagingButtonInfo = Pagination.getPagingButtonInfo(clients);
        final PagingResponse pagingResponse = PagingResponse.of(clients.getContent(), pagingButtonInfo);

        return ResponseEntity.ok(pagingResponse);
    }

    @GetMapping("/clients/{clientCode}")
    public ResponseEntity<SalesClientResponse> getSalesClient(@PathVariable final Long clientCode) {
        final SalesClientResponse salesClientResponse = clientService.getSalesClient(clientCode);
        return ResponseEntity.ok(salesClientResponse);
    }

    @PostMapping("/clients")
    public ResponseEntity<Void> save(@RequestBody final ClientCreateRequest clientCreateRequest) {
        final Long clientCode = clientService.save(clientCreateRequest, ClientType.PRODUCTS);
        return ResponseEntity.created(URI.create("/api/v1/clients/" + clientCode)).build();
    }

    @PutMapping("/clients/{clientCode}")
    public ResponseEntity<Void> modify(
            @PathVariable final Long clientCode,
            @RequestBody final ClientUpdateRequest clientRequest
    ) {
        clientService.modify(clientCode, clientRequest);
        return ResponseEntity.created(URI.create("/api/v1/clients/" + clientCode)).build();
    }


}
