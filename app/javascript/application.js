document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('search-input');
    const searchPath = document.getElementById('search-path').dataset.url;

    searchInput.addEventListener('input', function() {
        let query = this.value;

        if (query.length > 2) {
            fetch(searchPath, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
                },
                body: JSON.stringify({ q: query })
            })
                .then(response => response.json())
                .then(data => {
                    console.log(data); // Add this line to log the response data

                    const dropdown = document.getElementById('related-posts-dropdown');

                    dropdown.innerHTML = ''; // Clear the dropdown

                    if (data.length > 0) {
                        dropdown.classList.add('show'); // Show the dropdown if there are results
                    } else {
                        dropdown.classList.remove('show'); // Hide the dropdown if there are no results
                    }

                    data.forEach(post => {
                        const link = document.createElement('a');
                        link.href = '/posts/' + post.id; // This assumes that the show page URL is '/posts/:id'
                        link.textContent = post.title;
                        link.classList.add('dropdown-item'); // Add the 'dropdown-item' class
                        dropdown.appendChild(link);
                    });
                })
                .catch(error => console.error('Error:', error));
        }
    });
});

// comment nested system
document.addEventListener('DOMContentLoaded', function() {
    document.addEventListener('click', (event) => {
        if (event.target.matches('.comment-form-display')) {
            event.preventDefault();
            const replyLink = event.target;
            const commentForm = replyLink.nextElementSibling;
            commentForm.style.display = commentForm.style.display === 'none' ? 'block' : 'none';
        }
    });
});

