// Add functionality to the Clear All Data button for all sections
document.querySelectorAll('.clearButton').forEach(button => {
    button.addEventListener('click', function () {
        // Get the section name from the data-section attribute
        const section = button.getAttribute('data-section');

        // Confirm the action
        if (confirm(`Are you sure you want to clear all data for the ${section.replace('_', ' ')} section? This action cannot be undone.`)) {
            // Redirect to the backend script with the section name
            window.location.href = `/qac_ugc/Proposal_sections/Clear_Data_Button/clear_data.php?section=${section}`;
        }
    });
});
