document.addEventListener('turbolinks:load', function () {
  M.updateTextFields();

  // Inicializar textareas
  let elems = document.querySelectorAll('.materialize-textarea');
  if (elems.length) {
    elems.forEach(elem => M.textareaAutoResize(elem));
  }

  // Inicializar tooltips
  let tooltipElems = document.querySelectorAll('.tooltipped');
  M.Tooltip.init(tooltipElems);

  // Función para alternar el tema
  const themeToggler = document.getElementById('theme-toggler');
  const body = document.body;
  const nav = document.querySelector('nav');

  // Cargar la preferencia del tema del usuario desde localStorage
  if (localStorage.getItem('theme') === 'dark') {
    body.classList.add('dark-theme');
    nav.classList.add('dark-theme');
  }

  if (themeToggler) {
    themeToggler.addEventListener('click', function () {
      body.classList.toggle('dark-theme');
      nav.classList.toggle('dark-theme');

      // Guardar la preferencia del tema en localStorage
      if (body.classList.contains('dark-theme')) {
        localStorage.setItem('theme', 'dark');
      } else {
        localStorage.setItem('theme', 'light');
      }
    });
  }

  // Ordenar notas
  const orderSelect = document.getElementById('order-notes');
  const notesContainer = document.getElementById('notes-container');

  if (orderSelect && notesContainer) {
    // Cargar preferencia de orden desde localStorage
    const savedOrder = localStorage.getItem('order-notes');
    if (savedOrder) {
      orderSelect.value = savedOrder; // Establece el valor desde localStorage
      sortNotes(savedOrder); // Ordena las notas
    }

    // Escuchar cambios en el selector
    orderSelect.addEventListener('change', function () {
      const selectedOrder = orderSelect.value;
      localStorage.setItem('order-notes', selectedOrder);
      sortNotes(selectedOrder);
    });

    function sortNotes(order) {
      const notes = Array.from(notesContainer.children);
      notes.sort((a, b) => {
        const titleA = a.querySelector('.note-title')?.textContent?.trim() || '';
        const titleB = b.querySelector('.note-title')?.textContent?.trim() || '';
        const dateA = new Date(a.dataset.date || 0);
        const dateB = new Date(b.dataset.date || 0);

        switch (order) {
          case 'recent-desc':
            return dateB - dateA;
          case 'recent-asc':
            return dateA - dateB;
          case 'alpha-asc':
            return titleA.localeCompare(titleB);
          case 'alpha-desc':
            return titleB.localeCompare(titleA);
          default:
            return 0;
        }
      });

      // Reordenar las notas en el DOM sin disparar otros eventos
      const fragment = document.createDocumentFragment();
      notes.forEach(note => fragment.appendChild(note));
      notesContainer.appendChild(fragment);
    }
  }

  // Validación para evitar títulos duplicados
  const noteForm = document.getElementById('note-form');
  const noteTitleInput = document.getElementById('note-title');
  const errorMessage = document.getElementById('error-message');

  if (noteForm && noteTitleInput && notesContainer) {
    noteForm.addEventListener('submit', function (event) {
      event.preventDefault();

      const newNoteTitle = noteTitleInput.value.trim();

      // Verificar si el título ya existe
      const existingNote = Array.from(notesContainer.children).some(note => {
        const title = note.querySelector('.note-title')?.textContent.trim();
        return title === newNoteTitle;
      });

      if (existingNote) {
        // Mostrar mensaje de error
        errorMessage.textContent = 'Ya existe una nota con ese título. Por favor, elige otro título.';
        errorMessage.style.display = 'block';
      } else {
        // Ocultar mensaje de error y proceder con el guardado
        errorMessage.style.display = 'none';

        // Aquí puedes realizar la lógica de guardado (simulada para este ejemplo)
        saveNote(newNoteTitle);
      }
    });

    function saveNote(title) {
      // Lógica para guardar la nota localmente
      const newNote = document.createElement('div');
      newNote.classList.add('note');
      newNote.dataset.date = new Date().toISOString();
      newNote.innerHTML = `
        <h3 class="note-title">${title}</h3>
        <p>Contenido predeterminado de la nota</p>
      `;
      notesContainer.appendChild(newNote);
      console.log('Nota guardada:', title);
      noteTitleInput.value = '';
    }
  }
});
