import { loadQuartzConfig, loadQuartzLayout } from "./quartz/plugins/loader/config-loader"
import { siteOverrides } from "./sites"

// Repo này build nhiều site; scripts/build-site.sh đặt QUARTZ_SITE và copy
// sites/<site>/quartz.config.yaml ra gốc. Override TS của site phải chạy trước loadQuartzConfig().
const site = process.env.QUARTZ_SITE
if (site) siteOverrides[site]?.()

const config = await loadQuartzConfig()
export default config
export const layout = await loadQuartzLayout()
