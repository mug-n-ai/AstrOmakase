document.addEventListener("DOMContentLoaded", function() {
  const copyIcons = document.querySelectorAll(".copy-icon");

  copyIcons.forEach(icon => {
    icon.addEventListener("click", function() {
      const code = this.previousElementSibling.innerText;
      navigator.clipboard.writeText(code).catch(err => {
        console.error("Failed to copy code: ", err);
      });
    });
  });
});
