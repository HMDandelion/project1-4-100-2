package com.hmdandelion.project_1410002.sales.domain.repository.client;

import com.hmdandelion.project_1410002.sales.domain.entity.client.Client;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ClientRepoCustom {

    Page<Client> search(Pageable pageable);
}