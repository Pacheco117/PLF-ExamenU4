// Retrieve categories from the server and populate the category dropdown
function populateCategories() {
    // Make an AJAX request to fetch categories from the server
    // You can use the Fetch API or XMLHttpRequest for this purpose
    // Example using Fetch API:
    fetch('get_categories.php')
        .then(response => response.json())
        .then(categories => {
            const categorySelect = document.getElementById('product-category');
            categorySelect.innerHTML = '<option value="">Select Category</option>';
            categories.forEach(category => {
                const option = document.createElement('option');
                option.value = category.idCategoria;
                option.textContent = category.categoria;
                categorySelect.appendChild(option);
            });
        });
}

// Retrieve products from the server and populate the product table
function populateProducts() {
    // Make an AJAX request to fetch products from the server
    // Example using Fetch API:
    fetch('get_products.php')
        .then(response => response.json())
        .then(products => {
            const tableBody = document.getElementById('product-table-body');
            tableBody.innerHTML = '';
            products.forEach(product => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${product.idProducto}</td>
                    <td>${product.producto}</td>
                    <td>${product.precio}</td>
                    <td>${product.categoria}</td>
                    <td>
                        <button onclick="editProduct(${product.idProducto})">Edit</button>
                        <button onclick="deleteProduct(${product.idProducto})">Delete</button>
                    </td>
                `;
                tableBody.appendChild(row);
            });
        });
}

// Add or update a product
function saveProduct(event) {
    event.preventDefault();

    const productId = document.getElementById('product-id').value;
    const productName = document.getElementById('product-name').value;
    const productPrice = document.getElementById('product-price').value;
    const productCategory = document.getElementById('product-category').value;

    // Make an AJAX request to save the product
    // Example using Fetch API:
    fetch('save_product.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            idProducto: productId,
            producto: productName,
            precio: productPrice,
            idCategoria: productCategory
        })
    })
        .then(response => response.json())
        .then(response => {
            if (response.success) {
                // Clear the form
                document.getElementById('product-id').value = '';
                document.getElementById('product-name').value = '';
                document.getElementById('product-price').value = '';
                document.getElementById('product-category').value = '';

                // Refresh the product table
                populateProducts();
            } else {
                console.error(response.error);
            }
        });
}

// Edit a product
function editProduct(productId) {
    // Make an AJAX request to fetch the product details
    // Example using Fetch API:
    fetch(`get_product.php?id=${productId}`)
        .then(response => response.json())
        .then(product => {
            document.getElementById('product-id').value = product.idProducto;
            document.getElementById('product-name').value = product.producto;
            document.getElementById('product-price').value = product.precio;
            document.getElementById('product-category').value = product.idCategoria;
        });
}

// Delete a product
function deleteProduct(productId) {
    // Make an AJAX request to delete the product
    // Example using Fetch API:
    fetch(`delete_product.php?id=${productId}`, { method: 'DELETE' })
        .then(response => response.json())
        .then(response => {
            if (response.success) {
                // Refresh the product table
                populateProducts();
            } else {
                console.error(response.error);
            }
        });
}

// Initialize the page
function init() {
    populateCategories();
    populateProducts();

    const productForm = document.getElementById('product-form');
    productForm.addEventListener('submit', saveProduct);
}

// Call the init function when the page finishes loading
window.addEventListener('load', init);
