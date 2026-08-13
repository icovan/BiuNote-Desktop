/**
 * Bundled into dist-ui/desktop-bridge.js for the Tauri webview.
 * Exposes window.__BIUPRO_DESKTOP__ used by web/app/desktop-shell.js.
 */
import { getCurrentWindow } from '@tauri-apps/api/window'
import { open as openExternal } from '@tauri-apps/plugin-shell'
import { open as openDialog, save as saveDialog } from '@tauri-apps/plugin-dialog'
import { readTextFile, writeTextFile } from '@tauri-apps/plugin-fs'

const appWindow = getCurrentWindow()

window.__BIUPRO_DESKTOP_APP__ = true
window.__BIUPRO_DESKTOP__ = {
  ready: true,
  minimize: () => appWindow.minimize(),
  toggleMaximize: async () => {
    if (await appWindow.isMaximized()) await appWindow.unmaximize()
    else await appWindow.maximize()
  },
  close: () => appWindow.close(),
  startDragging: () => appWindow.startDragging(),
  openExternal: (url) => openExternal(url),
  openBiupuFile: async () => {
    const selected = await openDialog({
      multiple: false,
      filters: [{ name: 'BiuNote', extensions: ['bn'] }],
    })
    if (!selected) return null
    const path = String(selected)
    if (!/\.bn$/i.test(path)) {
      throw new Error('BN_ONLY')
    }
    const text = await readTextFile(path)
    return { path, text }
  },
  saveBiupuFile: async (contents, opts = {}) => {
    const path = await saveDialog({
      defaultPath: opts.defaultPath || opts.suggestedName || 'score.bn',
      filters: [{ name: 'BiuNote', extensions: ['bn'] }],
    })
    if (!path) return null
    await writeTextFile(path, contents)
    return String(path)
  },
}

document.documentElement.classList.add('is-desktop')
document.body?.classList?.add('is-desktop')
