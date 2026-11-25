---
title: Trang chủ
description: Trang chủ tài liệu CertNet — Tổng quan, Quản trị, Kiến trúc, Đặc tả, Tích hợp, Vận hành, Phụ lục
tags:
  - moc
  - certnet
---

# CertNet Docs

> **CertNet** là Layer-1 permissioned (PoA) mã nguồn mở — shared trust layer cho danh tính và chứng chỉ số (`did:certnet`, Credential Status, Trust Registry).  
> Mega app là **client**. CertNet **không thuộc** mega app.

## Đọc nhanh

| Bạn cần… | Đi tới |
|---|---|
| Hiểu CertNet là gì / không phải gì | [02. Tổng quan](02-overview/) |
| Quản trị & hai giai đoạn vận hành | [03. Quản trị](03-governance/) |
| Stack Cosmos / modules / PII | [04. Kiến trúc](04-architecture/) |
| Spec bắt buộc (roadmap 25/11) | [05. Đặc tả](05-specs/) |
| **API Contract & OpenAPI (ghép)** | [API Contract](06-developers/01-api/API-Contract) · [openapi.yaml](06-developers/01-api/openapi.yaml) |
| Gateway, phí & tự code | [Gateway](06-developers/01-api/Gateway) · [Tự implement](06-developers/02-guides/Implement-API-Contract) |
| SDK, localnet, checklist bàn giao | [06. Tích hợp](06-developers/) |
| Testnet / versioning / mainnet | [07. Vận hành](07-operations/) |
| Tra cứu thuật ngữ, mã lỗi, FAQ | [99. Phụ lục](99-appendices/) |

## Câu chốt nội bộ

> Mega app dùng CertNet. CertNet không thuộc mega app.

Nếu chỉ một app dùng và một bên kiểm soát hết → chain đắt và thừa. CertNet chỉ đáng khi là **shared infrastructure** cho nhiều issuer / verifier / app.

## Roadmap bàn giao (tham chiếu)

| Hạn | Gói |
|---|---|
| **25/11** | Spec DID / Status / Trust Registry · API & gateway · Phí & độ trễ ghi |
| **14/12** | Testnet · SDK/client · Test vector · Vận hành (changelog, lịch mainnet) |

## Bản đồ thư mục

```text
certnet-docs/
├── 01-get-started/       01. Bắt đầu
├── 02-overview/          02. Tổng quan
├── 03-governance/        03. Quản trị
├── 04-architecture/      04. Kiến trúc
├── 05-specs/             05. Đặc tả
├── 06-developers/        06. Tích hợp & Phát triển
│   ├── 01-api/           API & Cổng kết nối
│   ├── 02-guides/        Hướng dẫn triển khai
│   └── 03-testing/       Kiểm thử & Bàn giao
├── 07-operations/        07. Vận hành
└── 99-appendices/        99. Phụ lục (Glossary, Mã lỗi, FAQ)
```
