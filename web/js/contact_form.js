// ===== TOAST FUNCTIONS - Easy to swap libraries =====

// Notyf version:
const notyf = new Notyf({
    duration: 5000,
    position: { x: 'center', y: 'top' },
    dismissible: true,
    ripple: true
});

function showSuccessToast(message) {
    if (typeof notyf === 'undefined') {
        console.error('Notyf library not loaded! Falling back to alert.');
        alert('Success: ' + message);
        return;
    }
    notyf.success(message);
}

function showErrorToast(message) {
    if (typeof notyf === 'undefined') {
        console.error('Notyf library not loaded! Falling back to alert.');
        alert('Error: ' + message);
        return;
    } 
    notyf.error(message);
}

// iziToast version:
/*
function showSuccessToast(message) {
    if (typeof iziToast === 'undefined') {
        console.error('iziToast library not loaded! Falling back to alert.');
        alert('Success: ' + message);
        return;
    }
    iziToast.success({
        title: 'Success!',
        message: message,
        position: 'topRight',
        timeout: 5000,
        close: true,
        closeOnClick: true,
        progressBar: true
    });
}

function showErrorToast(message) {
    if (typeof iziToast === 'undefined') {
        console.error('iziToast library not loaded! Falling back to alert.');
        alert('Error: ' + message);
        return;
    }
    iziToast.error({
        title: 'Error!',
        message: message,
        position: 'topRight',
        timeout: 7000,
        close: true,
        closeOnClick: true,
        progressBar: true
    });
}
*/

// ===== FORM SUBMISSION HANDLER =====

async function handleSubmit(event) {
    event.preventDefault();
    var data = new FormData(event.target);  

    // Create AbortController for timeout
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), 10000); // 10 second timeout

    fetch(event.target.action, {
        method: event.target.method,
        body: data,
        headers: {
            'Accept': 'application/json'
        },
        signal: controller.signal
    }).then(response => {
        clearTimeout(timeoutId); // Clear timeout on successful response
        if (response.ok) {
            // Show success toast
            showSuccessToast("Message sent successfully! I'll get back to you soon.");

            // Reset the HTML form elements
            event.target.reset();

            // Reset your custom Jaspr components
            window.dispatchEvent(new CustomEvent('formReset'));
        } else {
            response.json().then(data => {
                let errorMessage = "Failed to send message. Please try again.";

                // More detailed error handling
                if (Object.hasOwn(data, 'errors')) {
                    errorMessage = data["errors"].map(error => error["message"]).join(", ");
                } else if (data.message) {
                    errorMessage = data.message;
                }

                // Show error toast
                showErrorToast(errorMessage);

                // Dispatch error event for Jaspr component
                window.dispatchEvent(new CustomEvent('formError'));
            }).catch(() => {
                // Fallback error message if JSON parsing fails
                showErrorToast("An unexpected error occurred. Please try again.");

                // Dispatch error event for Jaspr component
                window.dispatchEvent(new CustomEvent('formError'));
            });
        }
    }).catch(error => {
        clearTimeout(timeoutId); // Clear timeout on error

        let errorMessage = "Network error. Please check your connection and try again.";

        // Check if error was due to timeout
        if (error.name === 'AbortError') {
            errorMessage = "Request timed out. Please try again.";
        }

        // Show network error toast
        showErrorToast(errorMessage);

        // Dispatch error event for Jaspr component
        window.dispatchEvent(new CustomEvent('formError'));
    });
}

// Initialize when DOM is loaded
document.addEventListener('submit', function (event) {
    if (event.target.id === 'my-form') {
        handleSubmit(event);
    }
});