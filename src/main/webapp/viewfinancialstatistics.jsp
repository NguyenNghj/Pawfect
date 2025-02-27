<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Finance Statistics</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f3e5d8;
                color: #5d4037;
                text-align: center;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 40%;
                margin: 50px auto;
                padding: 20px;
                background: #d7ccc8;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }
            canvas {
                background: #efebe9;
                border-radius: 8px;
                padding: 10px;
            }
            
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Lượng Đơn Hàng</h2>
            <canvas id="sale-revenue"></canvas>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
        <script type="text/javascript">
            var chart = document.getElementById("sale-revenue").getContext("2d");
            var myChart = new Chart(chart, {
                type: "line",
                data: {
                    labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                    datasets: [{
                        label: "Sản phẩm",
                        data: [${requestScope.Month1}, ${requestScope.Month2}, ${requestScope.Month3}, ${requestScope.Month4}, ${requestScope.Month5},
                               ${requestScope.Month6}, ${requestScope.Month7}, ${requestScope.Month8}, ${requestScope.Month9}, ${requestScope.Month10},
                               ${requestScope.Month11}, ${requestScope.Month12}],
                        backgroundColor: "rgba(121, 85, 72, 0.5)",
                        borderColor: "#5d4037",
                        borderWidth: 2,
                        pointBackgroundColor: "#3e2723",
                        pointBorderColor: "#ffccbc"
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    }
                }
            });
        </script>
    </body>
</html>
