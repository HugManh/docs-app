// Đăng ký override TS của từng site. Thêm site mới: tạo sites/<tên>/overrides.ts rồi khai báo ở đây.
import brainIt from "./brain-it/overrides"

export const siteOverrides: Record<string, () => void> = {
  "brain-it": brainIt,
}
