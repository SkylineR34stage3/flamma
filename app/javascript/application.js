document.addEventListener('DOMContentLoaded', function() {
    var searchInput = document.getElementById('search-input');
    var searchPath = document.getElementById('search-path').dataset.url;

    searchInput.addEventListener('input', function() {
        var query = this.value;

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

                    var dropdown = document.getElementById('related-posts-dropdown');

                    dropdown.innerHTML = ''; // Clear the dropdown

                    data.forEach(post => {
                        var option = document.createElement('option');
                        option.value = post.id;
                        option.textContent = post.title;
                        dropdown.appendChild(option);
                    });
                })
                .catch(error => console.error('Error:', error));
        }
    });
});
