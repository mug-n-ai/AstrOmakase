document.addEventListener("DOMContentLoaded", function() {
    const copyButtons = document.querySelectorAll(".copy-btn");
  
    copyButtons.forEach(button => {
      button.addEventListener("click", function() {
        const code = this.previousElementSibling.querySelector('code').innerText;
        navigator.clipboard.writeText(code).catch(err => {
          console.error("Failed to copy code: ", err);
        });
      });
    });
  });
  