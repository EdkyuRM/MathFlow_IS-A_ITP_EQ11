//Configuración de conexión a Supabase
const SUPABASE_URL = 'http://127.0.0.1:54321'; // IP directa
const SUPABASE_ANON_KEY = 'sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH';
const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

let esRegistro = true;

//Control de la Interfaz
function cambiarModo() {
  esRegistro = !esRegistro;

  const title = document.getElementById("title");
  const btn = document.getElementById("btn");
  const toggle = document.getElementById("toggleText");
  
  // Elementos que solo se ven en Registro
  const campoNombre = document.getElementById("usuario");
  const campoRol = document.getElementById("rol");

  if (esRegistro) {
    title.innerText = "Crear cuenta nueva";
    btn.innerText = "Sign up";
    toggle.innerText = "¿Ya tienes cuenta? Inicia sesión";
    campoNombre.style.display = "block";
    campoRol.style.display = "block";
  } else {
    title.innerText = "Iniciar sesión";
    btn.innerText = "Login";
    toggle.innerText = "¿No tienes cuenta? Regístrate";
    campoNombre.style.display = "none";
    campoRol.style.display = "none";
  }
}

//Lógica de Autenticación
async function accionUsuario() {
  const email = document.getElementById("correo").value;
  const password = document.getElementById("password").value;
  const nombreReal = document.getElementById("usuario").value;
  const rol = document.getElementById("rol").value;

  // Validación básica
  if (!email || !password) {
    alert("Email y contraseña son obligatorios");
    return;
  }

  try {
    if (esRegistro) {
      if (!nombreReal || !rol) {
        alert("Por favor indica tu nombre y rol");
        return;
      }

      // Registro (guarda el nombre y rol en los 'user_metadata')
      const { data, error } = await _supabase.auth.signUp({
        email: email,
        password: password,
        options: {
          data: {
            full_name: nombreReal,
            role: rol
          }
        }
      });

      if (error) throw error;
      
      alert("Registro exitoso. Revisa tu correo de confirmación (simulación)");
      cambiarModo(); // Cambiam a login automáticamente

    // Reemplaza la parte final de tu función accionUsuario en script_login_signin.js
  } else {
    // --- Lógica de Login ---
    const { data, error } = await _supabase.auth.signInWithPassword({
      email: email,
      password: password
    });

    if (error) throw error;
    
    // Consultamos el rol en la tabla pública para saber a dónde mandarlo
    const { data: perfil, error: perfilError } = await _supabase
      .from('usuario')
      .select('tipo_usuario')
      .eq('id_usuario', data.user.id)
      .single();

    if (perfilError) {
      console.error("Error al obtener el rol:", perfilError);
      alert("Hubo un problema al verificar tu perfil.");
      return;
    }

    // Redirección inteligente
    if (perfil.tipo_usuario === 'Docente') {
      window.location.href = "dashboard_docente.html";
    } else {
      window.location.href = "bienvenida.html";
    }
  }

  } catch (err) {
    alert("Error: " + err.message);
    console.error(err);
  }
}