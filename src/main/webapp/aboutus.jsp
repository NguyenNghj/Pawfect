<%-- 
    Document   : aboutus
    Created on : Mar 11, 2025, 11:14:56 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="./components/header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-dark: #2563eb;
                --secondary: #64748b;
                --success: #10b981;
                --info: #06b6d4;
                --warning: #f59e0b;
                --danger: #ef4444;
                --light: #f8fafc;
                --dark: #1e293b;
            }

            .bg-secondary {
                background-color: var(--secondary) !important;
            }
            .bg-success {
                background-color: var(--success) !important;
            }
            .bg-info {
                background-color: var(--info) !important;
            }
            .bg-warning {
                background-color: var(--warning) !important;
            }
            .bg-danger {
                background-color: var(--danger) !important;
            }
            .bg-light {
                background-color: var(--light) !important;
            }
            .bg-dark {
                background-color: var(--dark) !important;
            }

            .text-primary {
                color: var(--primary) !important;
            }
            .text-secondary {
                color: var(--secondary) !important;
            }
            .text-success {
                color: var(--success) !important;
            }
            .text-info {
                color: var(--info) !important;
            }
            .text-warning {
                color: var(--warning) !important;
            }
            .text-danger {
                color: var(--danger) !important;
            }
            .text-light {
                color: var(--light) !important;
            }
            .text-dark {
                color: var(--dark) !important;
            }

            .btn-primary {
                background-color: var(--primary);
                border-color: var(--primary);
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
            }

            .btn-outline-primary {
                color: var(--primary);
                border-color: var(--primary);
            }

            .btn-outline-primary:hover {
                background-color: var(--primary);
                border-color: var(--primary);
            }

            .nav-link.active {
                color: var(--primary) !important;
                font-weight: bold;
            }

            .breadcrumb1 {
                background-color: #ffffff;
                list-style: none;
                display: flex;
                padding: 15px 0 15px 50px;
                border-radius: 10px;
                font-size: 20px;
            }

            .breadcrumb1-item:not(.active) a {
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <!-- Breadcrumb -->
        <div class="row bread" style="background-color: white;">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb1 m-0">
                    <li class="breadcrumb1-item"><a href="/pawfect" style="color: #D3A376;">Trang chủ</a></li>
                    <li class="breadcrumb1-item active" aria-current="page">&nbsp;&nbsp;/&nbsp;&nbsp;Giới thiệu</li>
                </ol>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="mb-5 pb-3" style="background-color: #f4f4f4; border-radius: 7px">
            <main class="container py-4">          
                <div class="row">
                    <div class="col-lg-8">
                        <!-- Main Content -->
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h1 class="mb-4" style="color: #8a6f5e"><b>Về PetCare</b></h1>

                                <p class="lead">
                                    Chào bạn! Tại PetCare, chúng tôi luôn tâm niệm rằng thú cưng cũng là thành viên trong gia đình và chúng ta phải yêu thương, chăm sóc chúng như thế. Chính vì vậy, chúng tôi đặt sự quan tâm và chăm sóc đến thú cưng của bạn lên hàng đầu.
                                </p>

                                <div class="my-4">
                                    <img src="https://via.placeholder.com/700x300" alt="Pet Care Services" class="img-fluid rounded">
                                </div>

                                <p>
                                    Chúng tôi tự hào là địa chỉ tin cậy đã được hơn 15.000 khách hàng tin tưởng sử dụng dịch vụ và mua sắm từ năm 2017 tới nay tại số 123 Đường ABC, Thành phố XYZ.
                                </p>

                                <p>
                                    PetCare có đội ngũ đều là những bác sĩ thú y có trình độ, cũng là những người nuôi thú cưng nên sẽ tư vấn giúp bạn chọn lựa chọn những sản phẩm hợp nhất. Chúng tôi cung cấp nhiều loại đồ dùng, thức ăn cho thú cưng được nhập chính hãng từ các thương hiệu, nhà phân phối hàng đầu.
                                </p>

                                <p>
                                    Các sản phẩm chúng tôi bán không chỉ thân thiện với vật nuôi mà chúng đã được đội ngũ của chúng tôi lựa chọn cẩn thận và trải nghiệm để đảm bảo phù hợp, đáng tiền, đáp ứng nhu cầu của thú cưng của bạn, giúp chúng vui vẻ và khỏe mạnh, còn bạn sẽ dễ dàng và yên tâm hơn khi mua sắm.
                                </p>

                                <div class="row mt-5 mb-4">
                                    <div class="col-md-4 mb-3">
                                        <div class="card text-center h-100">
                                            <div class="card-body">
                                                <div class="mb-3">
                                                    <i class="fas fa-paw" style="font-size: 2.5rem; color: #D3A376"></i>
                                                </div>
                                                <h5 class="card-title">Sản phẩm chất lượng</h5>
                                                <p class="card-text">Nhập khẩu chính hãng từ các thương hiệu uy tín hàng đầu</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="card text-center h-100">
                                            <div class="card-body">
                                                <div class="mb-3">
                                                    <i class="fas fa-user-md" style="font-size: 2.5rem; color: #D3A376"></i>
                                                </div>
                                                <h5 class="card-title">Đội ngũ chuyên nghiệp</h5>
                                                <p class="card-text">Bác sĩ thú y và nhân viên có kinh nghiệm chăm sóc thú cưng</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="card text-center h-100">
                                            <div class="card-body">
                                                <div class="mb-3">
                                                    <i class="fas fa-truck" style="font-size: 2.5rem; color: #D3A376"></i>
                                                </div>
                                                <h5 class="card-title">Giao hàng nhanh chóng</h5>
                                                <p class="card-text">Đảm bảo giao hàng đúng thời gian và địa điểm mong muốn</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <p>
                                    Website của chúng tôi ra đời với mục tiêu phục vụ khách hàng tốt hơn, để bạn có thể mua sắm trực tuyến, thuận tiện và tiết kiệm thời gian.
                                </p>

                                <p>
                                    Chúng tôi có gắng cung cấp cho bạn trải nghiệm mua sắm trực tuyến tốt nhất có thể. Trang web của chúng tôi được thiết kế đơn giản, dễ sử dụng và cập nhật liên tục với các sản phẩm mới nhất, thông tin chi tiết và đầy đủ về các sản phẩm cũng như chính sách bán hàng.
                                </p>

                                <p>
                                    Bạn có thể tìm kiếm và chọn lựa từ một danh mục đa dạng các sản phẩm thú cưng của chúng tôi, bao gồm thức ăn, đồ chơi, đồ dùng và nhiều hơn nữa. Với đội ngũ chăm sóc khách hàng tận tâm, chúng tôi sẽ luôn sẵn sàng hỗ trợ bạn trong mọi vấn đề liên quan đến sản phẩm, dịch vụ và đơn hàng của bạn.
                                </p>

                                <p>
                                    Ngoài ra, chúng tôi cũng cam kết bảo mật thông tin của khách hàng, đảm bảo giao hàng đúng thời gian và địa điểm mong muốn, đồng thời cung cấp các hình thức thanh toán an toàn và tiện lợi.
                                </p>

                                <p class="mb-0">
                                    Với sứ mệnh trở thành địa chỉ tin cậy hàng đầu, chúng tôi luôn nỗ lực không ngừng để đáp ứng tốt nhất các nhu cầu mua sắm của khách hàng và trở thành địa chỉ tin cậy cho các tín đồ yêu thú cưng.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <!-- Sidebar -->
                        <div class="card shadow-sm mb-4">
                            <div class="card-header text-white" style="background-color: #8C6E63">
                                <h5 class="mb-0">Liên hệ với chúng tôi</h5>
                            </div>
                            <div class="card-body">
                                <ul class="list-unstyled">
                                    <li class="mb-3">
                                        <i class="fas fa-map-marker-alt me-2"></i> 600 Nguyễn Văn Cừ, An Bình, Bình Thủy, Cần Thơ
                                    </li>
                                    <li class="mb-3">
                                        <i class="fas fa-phone-alt me-2"></i> 0967017222
                                    </li>
                                    <li class="mb-3">
                                        <i class="fas fa-envelope me-2"></i> pawfectg3@gmail.com
                                    </li>
                                    <li>
                                        <i class="fas fa-clock me-2"></i> 8:00 - 20:00 (Thứ 2 - Chủ nhật)
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="card shadow-sm mb-4">
                            <div class="card-header text-white" style="background-color: #8C6E63">
                                <h5 class="mb-0">Dịch vụ của chúng tôi</h5>
                            </div>
                            <div class="card-body">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item d-flex align-items-center">
                                        <i class="fa-solid fa-paw me-2"></i></i> Sản phẩm cho thú cưng
                                    </li>
                                    <li class="list-group-item d-flex align-items-center">
                                        <i class="fas fa-home me-2"></i> Khách sạn thú cưng
                                    </li>
                                    <li class="list-group-item d-flex align-items-center">
                                        <i class="fas fa-truck me-2"></i> Giao hàng tận nơi
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <!--                    <div class="card shadow-sm">
                                                <div class="card-body text-center">
                                                    <h5 class="card-title">Đăng ký nhận tin</h5>
                                                    <p class="card-text">Nhận thông tin về sản phẩm mới và khuyến mãi</p>
                                                    <div class="input-group mb-3">
                                                        <input type="email" class="form-control" placeholder="Email của bạn">
                                                        <button class="btn btn-primary" type="button">Đăng ký</button>
                                                    </div>
                                                </div>
                                            </div>-->
                    </div>
                </div>
            </main>
        </div>

        <%@include file="./components/footer.jsp" %>
    </body>
</html>


