use tauri::Manager;

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
  tauri::Builder::default()
    .plugin(tauri_plugin_shell::init())
    .plugin(tauri_plugin_dialog::init())
    .plugin(tauri_plugin_fs::init())
    .setup(|app| {
      if let Some(win) = app.get_webview_window("main") {
        // Remove Windows DWM shadow/border so frameless chrome is even on all sides.
        let _ = win.set_shadow(false);
      }
      Ok(())
    })
    .run(tauri::generate_context!())
    .expect("error while running BiuNote desktop");
}
