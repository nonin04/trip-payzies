document.addEventListener("turbo:load", () => {

  const menuBtn = document.querySelector("#menu-btn");
  const sidebar = document.getElementById("sidebar");

  menuBtn.addEventListener('click', () =>{
    sidebar.classList.toggle("opacity-0")
    sidebar.classList.toggle("pointer-events-none")
  });
});

