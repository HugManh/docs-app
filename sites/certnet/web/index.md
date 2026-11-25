---
title: Home
description: Trang chủ tài liệu CertNet – điểm vào overview, specs, API, developers
tags:
  - moc
  - certnet
---

# CertNet Docs

> **CertNet** là Layer-1 permissioned (PoA) mã nguồn mở – shared trust layer cho danh tính và chứng chỉ số (`did:certnet`, Credential Status, Trust Registry).  
> Mega app là **client**. CertNet **không thuộc** mega app.

## Đọc nhanh

| Bạn cần… | Đi tới |
|---|---|
| Hiểu CertNet là gì / không phải gì | [Overview](overview/) |
| Quản trị & hai giai đoạn vận hành | [Governance](governance/) |
| Stack Cosmos / modules / PII | [Architecture](architecture/) |
| Spec bắt buộc (roadmap 25/11) | [Specs](specs/) |
| **API Contract + OpenAPI (ghép)** | [API Contract](api/API-Contract) · [openapi.yaml](api/openapi.yaml) |
| **Tự implement surface** | [Implement API Contract](developers/Implement-API-Contract) |
| Gateway, phí | [API](api/) |
| SDK, localnet, checklist bàn giao | [Developers](developers/) |
| Testnet / versioning / mainnet | [Operations](operations/) |
| Thuật ngữ | [Glossary](get-started/Glossary) |

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
├── get-started/          Getting started
├── overview/       What & why
├── governance/     Org & phases
├── architecture/   Stack & modules
├── specs/          DID · Status · Trust
├── api/            Gateway & fees
├── developers/     SDK · localnet
└── operations/     Testnet · mainnet
```
