<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>HKF - Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="{{asset('./AdminPanel/vendor/fontawesome-free/css/all.min.css')}}" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
    <link rel='stylesheet' href="{{asset('./css/style.css')}}">
    <!-- Custom styles for this template-->
    <link href="{{asset('./AdminPanel/css/sb-admin-2.min.css')}}" rel="stylesheet">
<!-- use the latest release -->
<script src="https://unpkg.com/vuejs-paginate-next@latest/dist/vuejs-paginate-next.umd.js"></script>
<!-- or use the specify version -->
<script src="https://unpkg.com/vuejs-paginate-next@1.0.2/dist/vuejs-paginate-next.umd.js"></script>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="app">
    </div>
    <!-- Bootstrap core JavaScript-->
    <script src="{{asset('./AdminPanel/vendor/jquery/jquery.min.js')}}"></script>
    <script src="{{asset('./AdminPanel/vendor/bootstrap/js/bootstrap.bundle.min.js')}}"></script>

    <!-- Core plugin JavaScript-->
    <script src="{{asset('./AdminPanel/vendor/jquery-easing/jquery.easing.min.js')}}"></script>

    <!-- Custom scripts for all pages-->
    <script src="{{asset('./AdminPanel/js/sb-admin-2.min.js')}}"></script>

    <!-- Page level plugins -->
    <script src="{{asset('./AdminPanel/vendor/chart.js/Chart.min.js')}}"></script>

    <!-- Page level custom scripts -->
    <script src="{{asset('./AdminPanel/js/demo/chart-area-demo.js')}}"></script>
    <script src="{{asset('./AdminPanel/js/demo/chart-pie-demo.js')}}"></script>
    {{-- <script type="module" src="{{ mix('resources/js/app.js') }}"></script> --}}
    {{-- <!-- <script src="{{ mix('/js/app.js') }}"></script> --> --}}
    @vite('resources/js/app.js')
</body>

</html>
