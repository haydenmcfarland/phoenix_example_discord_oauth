function setMode(transition = false) {
  const body = document.querySelector("body");
  if (localStorage.getItem("mode") === "dark") {
    body.classList.add("dark");
  } else {
    body.classList.remove("dark");
  }

  if (!transition) body.classList.add("notransition");
  else body.classList.remove("notransition");
}

function toggleDarkMode() {
  localStorage.setItem(
    "mode",
    (localStorage.getItem("mode") || "dark") === "dark" ? "light" : "dark"
  );
  setMode(transition=true);
}

document.addEventListener("DOMContentLoaded", () => {
  setMode();
  document.querySelector(".dark-toggle").addEventListener("click", function () {
    toggleDarkMode();
    const i = this.querySelector("i");
    if (i.innerHTML === "brightness_4") i.innerHTML = "brightness_high";
    else i.innerHTML = "brightness_4";
  });
});
