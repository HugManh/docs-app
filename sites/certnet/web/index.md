---
title: Trang chủ
description: Trang chủ tài liệu CertNet — Tổng quan, Quản trị, Kiến trúc, Đặc tả, Tích hợp, Vận hành
tags:
  - moc
  - certnet
---

# CertNet Docs

> **CertNet** là Layer-1 permissioned (PoA) mã nguồn mở — shared trust layer cho danh tính và chứng chỉ số (did:certnet, Credential Status, Trust Registry).  
> Mega app là **client**. CertNet **không thuộc** mega app.

## Đọc nhanh

| Bạn cần… | Đi tới |
|---|---|
| Hiểu CertNet là gì / không phải gì | [Tổng quan](overview/) |
| Quản trị & hai giai đoạn vận hành | [Quản trị](governance/) |
| Stack Cosmos / modules / PII | [Kiến trúc](architecture/) |
| Spec bắt buộc (roadmap 25/11) | [Đặc tả](specs/) |
| **API Contract & OpenAPI (ghép)** | [API Contract](developers/API-Contract) · [openapi.yaml](developers/openapi.yaml) |
| Gateway, phí & tự code | [Gateway](developers/Gateway) · [Tự implement](developers/Implement-API-Contract) |
| SDK, localnet, checklist bàn giao | [Tích hợp](developers/) |
| Testnet / versioning / mainnet | [Vận hành](operations/) |
| Thuật ngữ | [Thuật ngữ](get-started/Glossary) |

## Câu chốt nội bộ

> Mega app dùng CertNet. CertNet không thuộc mega app.

Nếu chỉ một app dùng và một bên kiểm soát hết → chain đắt và thừa. CertNet chỉ đáng khi là **shared infrastructure** cho nhiều issuer / verifier / app.

## Roadmap bàn giao (tham chiếu)

| Hạn | Gói |
|---|---|
| **25/11** | Spec DID / Status / Trust Registry · API & gateway · Phí & độ trễ ghi |
| **14/12** | Testnet · SDK/client · Test vector · Vận hành (changelog, lịch mainnet) |

## Bản đồ thư mục

`	ext
certnet-docs/
├── get-started/          Bắt đầu & Thuật ngữ
├── overview/             Tổng quan
├── governance/           Quản trị
├── architecture/         Kiến trúc
├── specs/                Đặc tả
├── developers/           Tích hợp (API, Gateway, SDK, Localnet)
└── operations/           Vận hành
`
