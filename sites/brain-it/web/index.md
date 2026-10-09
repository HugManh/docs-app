---
title: Trang chủ
description: Ghi chép cá nhân của Hug Manh về AI, kiến trúc phần mềm, API, lập trình và hệ thống.
---

# Brain-IT

Đây là nơi mình ghi lại những gì học được trong quá trình làm phần mềm: từ kiến trúc Transformer, DeepSeek, LoRA, đến Design Patterns, chuẩn thiết kế API và vận hành hệ thống.

Mỗi ghi chú chỉ nói về **một ý**, và được nối với nhau bằng link. Muốn đọc theo mạch, hãy bắt đầu từ một **chủ đề** bên dưới. Muốn tìm nhanh, dùng ô tìm kiếm (`Ctrl + K`).

## Chủ đề

```base
filters:
  and:
    - file.hasTag("moc")
views:
  - type: cards
    name: Chủ đề
    order:
      - file.name
      - description
    sort:
      - property: file.name
        direction: ASC
```

## Mới cập nhật

```base
filters:
  and:
    - file.inFolder("notes")
    - file.name != "index"
formulas:
  updated: file.mtime.format("DD/MM/YYYY")
properties:
  file.name:
    displayName: Ghi chú
  formula.updated:
    displayName: Cập nhật
views:
  - type: table
    name: Mới cập nhật
    order:
      - file.name
      - tags
      - formula.updated
    sort:
      - property: file.mtime
        direction: DESC
    limit: 12
```

[[notes/index|Xem tất cả ghi chú →]]
