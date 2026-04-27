let esRegistro = true;

function cambiarModo() {
  esRegistro = !esRegistro;

  const title = document.getElementById("title");
  const btn = document.getElementById("btn");
  const toggle = document.getElementById("toggleText");
  const rol = document.getElementById("rol");

  if (esRegistro) {
    title.innerText = "Crear cuenta nueva";
    btn.innerText = "Sign up";
    toggle.innerText = "¿Ya tienes cuenta? Inicia sesión";
    rol.style.display = "block";
  } else {
    title.innerText = "Iniciar sesión";
    btn.innerText = "Login";
    toggle.innerText = "¿No tienes cuenta? Regístrate";
    rol.style.display = "none";
  }
}

function accionUsuario() {
  const usuario = document.getElementById("usuario").value;
  localStorage.setItem("usuario", usuario);
  const password = document.getElementById("password").value;

  if (usuario === "" || password === "") {
    alert("Completa todos los campos");
    return;
  }

  if (esRegistro) {
    const rol = document.getElementById("rol").value;
    localStorage.setItem("rol", rol);
    if (rol === "") {
      alert("Selecciona un rol");
      return;
    }

    alert("Registro exitoso (simulado)");

const rolGuardado = localStorage.getItem("rol");

if (rolGuardado === "profesor") {
  window.location.href = "perfil_profesor.html";
} else {
  window.location.href = "bienvenida.html";
}
  }
}