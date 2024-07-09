<template>

</template>
<script>
    export default {
      mounted() {
        // Get the current hostname
        const hostname = window.location.hostname;

        // Define the base URL based on the hostname
        let baseUrl;
        if (hostname === '127.0.0.1' || hostname === 'localhost') {
          baseUrl = ''; // Development environment
        } else {
          baseUrl = 'https://hkferp.com'; // Production environment
        }

        // Generate the full URL for the asset file
        const assetUrl = `${baseUrl}/resources/js/app-f56b4100.js`;

        // Use the assetUrl variable in your code
        const script = document.createElement('script');
        script.src = assetUrl;
        document.head.appendChild(script);
      },
    };
  </script>
