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
            Toastify({
                text: "Message sent successfully! I'll get back to you soon.",
                duration: 5000,
                close: true,
                gravity: "top",
                position: "right",
                backgroundColor: "transparent",
                className: "toast-success",
                stopOnFocus: true,
            }).showToast();

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
                Toastify({
                    text: errorMessage,
                    duration: 7000,
                    close: true,
                    gravity: "top",
                    position: "right",
                    backgroundColor: "transparent",
                    className: "toast-error",
                    stopOnFocus: true,
                }).showToast();

                // Dispatch error event for Jaspr component
                window.dispatchEvent(new CustomEvent('formError'));
            }).catch(() => {
                // Fallback error message if JSON parsing fails
                Toastify({
                    text: "An unexpected error occurred. Please try again.",
                    duration: 7000,
                    close: true,
                    gravity: "top",
                    position: "right",
                    backgroundColor: "transparent",
                    className: "toast-error",
                    stopOnFocus: true,
                }).showToast();

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
        Toastify({
            text: errorMessage,
            duration: 7000,
            close: true,
            gravity: "top",
            position: "right",
            backgroundColor: "transparent",
            className: "toast-error",
            stopOnFocus: true,
        }).showToast();

        // Dispatch error event for Jaspr component
        window.dispatchEvent(new CustomEvent('formError'));
    });
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById("my-form");
    if (form) {
        form.addEventListener("submit", handleSubmit);
    }
});