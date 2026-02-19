import { defineConfig } from 'vitepress'
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'
import path from 'path'
import mathjax3 from 'markdown-it-mathjax3'

// https://vitepress.dev/reference/site-config

// Navigation menu items - each section from the sidebar becomes a menu item
const navItems = [
  { text: 'Home', link: '/' },
  { text: 'API', link: '/api' },
  { text: 'ErrorMetric', link: '/types'},
]

// Sidebar configuration - organized by sections
const sidebarItems = [
  {
    text: 'Getting Started',
    items: [
      { text: 'Home', link: '/' },
    ]
  },
  {
    text: 'Documentation',
    collapsed: false,
    items: [
      { text: 'API', link: '/api' },
      { text: 'Types', link: '/types' },
    ]
  },
]

// Sidebar configuration that shows sections when on Types page
const sidebar = {
  '/': sidebarItems,
  '/api': sidebarItems,
  '/types': [
    {
      text: 'Getting Started',
      items: [
        { text: 'Home', link: '/' },
      ]
    },
    {
      text: 'Documentation',
      collapsed: false,
      items: [
        { text: 'API', link: '/api' },
        { text: 'Types', link: '/types' },
        { text: 'ErrorMetric', link: '/types#errormetric' },
        { text: 'Error-based Metrics', link: '/types#error-based-metrics' },
        { text: 'Nash-Sutcliffe Efficiency Metrics', link: '/types#nash-sutcliffe-efficiency-metrics' },
        { text: 'Correlation-based Metrics', link: '/types#correlation-based-metrics' },
        { text: 'Rank Correlation Metrics', link: '/types#rank-correlation-metrics' },
        { text: 'All ErrorMetric Types', link: '/types#all-errormetric-types' },
      ]
    },
  ],
}

export default defineConfig({
  base: 'REPLACE_ME_DOCUMENTER_VITEPRESS',
  title: "ErrorMetrics.jl",
  description: "A Julia package providing error / performance metrics for comparing model outputs with observations",
  lastUpdated: true,
  cleanUrls: false,
  ignoreDeadLinks: true,
  outDir: 'REPLACE_ME_DOCUMENTER_VITEPRESS',
  
  head: [
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    ['script', {}, `
      window.MathJax = {
        tex: {
          inlineMath: [['$', '$'], ['\\\\(', '\\\\)']],
          displayMath: [['$$', '$$'], ['\\\\[', '\\\\]']],
        },
        options: {
          skipHtmlTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code']
        },
        startup: {
          ready: () => {
            MathJax.startup.defaultReady();
            MathJax.startup.promise.then(() => {
              if (MathJax.typesetPromise) {
                MathJax.typesetPromise();
              }
            });
          }
        }
      };
    `],
    ['script', { 
      type: 'text/javascript',
      id: 'MathJax-script',
      async: true,
      src: 'https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js'
    }],
  ],
  
  vite: {
    define: {
      __DEPLOY_ABSPATH__: JSON.stringify('REPLACE_ME_DOCUMENTER_VITEPRESS_DEPLOY_ABSPATH'),
    },
    resolve: {
      alias: {
        '@': path.resolve(__dirname, '../components')
      }
    },
    build: {
      assetsInlineLimit: 0,
    },
    optimizeDeps: {
      exclude: [ 
        '@nolebase/vitepress-plugin-enhanced-readabilities/client',
        'vitepress',
        '@nolebase/ui',
      ], 
    }, 
    ssr: { 
      noExternal: [ 
        '@nolebase/vitepress-plugin-enhanced-readabilities',
        '@nolebase/ui',
      ], 
    },
  },

  markdown: {
    math: true,
    config(md) {
      md.use(tabsMarkdownPlugin)
      md.use(mathjax3)
    },
    theme: {
      light: "github-light",
      dark: "github-dark"
    }
  },

  themeConfig: {
    outline: 'deep',
    search: {
      provider: 'local',
      options: {
        detailedView: true
      }
    },

    nav: navItems,
    sidebar: sidebar,
    socialLinks: [
      {
        icon: "github",
        link: 'https://github.com/LandEcosystems/ErrorMetrics.jl',
        ariaLabel: 'ErrorMetrics.jl repository'
      },
    ],
    footer: {
      message: 'ErrorMetrics.jl - Error and performance metrics for model evaluation',
      copyright: '© Copyright 2025 <strong>ErrorMetrics.jl Contributors</strong>'
    }
  }
})
