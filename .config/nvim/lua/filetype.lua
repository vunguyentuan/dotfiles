vim.filetype.add {
  extension = {
    conf = 'conf',
    env = 'dotenv',
    tiltfile = 'tiltfile',
    Tiltfile = 'tiltfile',
  },
  filename = {
    ['.env'] = 'bash',
    ['tsconfig.json'] = 'jsonc',
    ['.yamlfmt'] = 'yaml',
  },
  pattern = {
    ['%.env%.[%w_.-]+'] = 'bash',
  },
}
