// .vitepress/theme/index.ts
import { h } from 'vue'
import DefaultTheme from 'vitepress/theme'
import type { Theme as ThemeConfig } from 'vitepress'

import { 
  NolebaseEnhancedReadabilitiesMenu, 
  NolebaseEnhancedReadabilitiesScreenMenu, 
} from '@nolebase/vitepress-plugin-enhanced-readabilities/client'

import { enhanceAppWithTabs } from 'vitepress-plugin-tabs/client'

import '@nolebase/vitepress-plugin-enhanced-readabilities/client/style.css'
import './style.css'

export const Theme: ThemeConfig = {
  extends: DefaultTheme,
  Layout() {
    return h(DefaultTheme.Layout, null, {
      'nav-bar-content-after': () => [
        h(NolebaseEnhancedReadabilitiesMenu),
      ],
      'nav-screen-content-after': () => h(NolebaseEnhancedReadabilitiesScreenMenu),
    })
  },
  enhanceApp({ app, router }) {
    enhanceAppWithTabs(app);
    
    // Trigger MathJax rendering after route changes
    if (typeof window !== 'undefined') {
      router.onAfterRouteChanged = () => {
        setTimeout(() => {
          if (window.MathJax && window.MathJax.typesetPromise) {
            window.MathJax.typesetPromise().catch((err: any) => {
              console.error('MathJax typeset error:', err);
            });
          }
        }, 100);
      };
    }
  }
}
export default Theme
