return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    'html',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  -- Only detect Tailwind in projects that actually use it
  root_markers = {
    'tailwind.config.js',
    'tailwind.config.ts',
    'package.json'
  },
  -- Server settings
  settings = {
    tailwindCSS = {
      suggest = true,
      hover = true,
      completion = true,
      validate = true,
      colorDecorators = true,
      experimental = {
        classRegex = {
          -- Standard className
          [[className="([^"]*)"]],
          -- Template literals
          [[className={?`([^`]*)`}?]],
          -- Other common patterns
          [[tw="([^"]*)"]],
          [[tw={?`([^`]*)`}?]],
          [[\bclsx\(([^)]*)]],
          [[clsx\(([^)]*)]],
          [[cva\(([^)]*)]],
        },
      },
    },
  },
}

