document.getElementById('runLs').addEventListener('click', () => {
  chrome.runtime.sendNativeMessage(
    'com.example.ls',
    { args: [] },  // You can pass arguments here if needed
    (response) => {
      const outputDiv = document.getElementById('output');
      if (chrome.runtime.lastError) {
        outputDiv.textContent = 'Error: ' + chrome.runtime.lastError.message;
      } else if (response && response.output) {
        outputDiv.textContent = response.output;
      } else {
        outputDiv.textContent = 'No response received';
      }
    }
  );
});
