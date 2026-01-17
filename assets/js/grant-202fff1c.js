(function () {
  const PASSWORD = "jjjs123";
  const STORAGE_KEY = "doc_access_granted";

  // 已验证过，直接放行
  if (localStorage.getItem(STORAGE_KEY) === "yes") {
    return;
  }

  // ===== 创建遮罩 =====
  const overlay = document.createElement("div");
  overlay.style.position = "fixed";
  overlay.style.top = "0";
  overlay.style.left = "0";
  overlay.style.width = "100vw";
  overlay.style.height = "100vh";
  overlay.style.background = "rgba(0, 0, 0, 1)";
  overlay.style.zIndex = "9999";
  overlay.style.display = "flex";
  overlay.style.alignItems = "center";
  overlay.style.justifyContent = "center";

  // ===== 创建弹窗 =====
  const modal = document.createElement("div");
  modal.style.background = "#fff";
  modal.style.padding = "24px";
  modal.style.borderRadius = "8px";
  modal.style.width = "320px";
  modal.style.boxShadow = "0 10px 30px rgba(0,0,0,0.3)";
  modal.style.textAlign = "center";
  modal.style.fontFamily = "system-ui, -apple-system, BlinkMacSystemFont";

  modal.innerHTML = `
    <h3 style="margin-bottom:16px;">请输入访问密码</h3>
    <input
      type="password"
      id="passwordInput"
      placeholder="密码"
      style="width:100%;padding:8px;margin-bottom:12px;font-size:16px;box-sizing:border-box;"
    />
    <div id="errorMsg" style="color:red;display:none;margin-bottom:8px;">
      密码错误
    </div>
    <button
      id="submitBtn"
      style="width:100%;padding:10px;font-size:16px;cursor:pointer;"
    >
      确认
    </button>
  `;

  overlay.appendChild(modal);
  document.body.appendChild(overlay);

  const input = modal.querySelector("#passwordInput");
  const button = modal.querySelector("#submitBtn");
  const errorMsg = modal.querySelector("#errorMsg");

  function checkPassword() {
    if (input.value === PASSWORD) {
      localStorage.setItem(STORAGE_KEY, "yes");
      overlay.remove();
    } else {
      errorMsg.style.display = "block";
      input.value = "";
      input.focus();
    }
  }

  button.addEventListener("click", checkPassword);
  input.addEventListener("keydown", (e) => {
    if (e.key === "Enter") checkPassword();
  });

  input.focus();
})();