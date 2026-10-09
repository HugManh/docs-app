import { loadQuartzConfig, loadQuartzLayout } from "./quartz/plugins/loader/config-loader"
import { componentRegistry } from "./quartz/components/registry"

// Cách viết theo docs `ExternalPlugin.Explorer({...})` chưa chạy với plugin npm có scope
// (https://github.com/jackyzha0/quartz/issues/2565), nên đặt override trực tiếp vào registry.
// Các callback được serialize bằng toString() và chạy ở trình duyệt -> phải tự chứa.
componentRegistry.setOptionOverrides("@quartz-community/explorer", {
  // Trên web chỉ điều hướng theo chủ đề (MOC); kho ghi chú tìm qua search, link, tag.
  filterFn: (node: { slugSegment: string }) =>
    !["notes", "assets", "tags"].includes(node.slugSegment),
  mapFn: (node: { isFolder: boolean; displayName: string }) => {
    if (!node.isFolder) node.displayName = node.displayName.replace(/\s*MOC$/i, "")
  },
})

const config = await loadQuartzConfig()
export default config
export const layout = await loadQuartzLayout()
