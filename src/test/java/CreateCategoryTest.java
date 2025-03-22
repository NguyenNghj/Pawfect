
import controller.CreateCategoryServlet;
import dao.CategoryDAO;
import model.Category;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.MockitoJUnitRunner;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import static org.mockito.Mockito.*;

@RunWith(MockitoJUnitRunner.class)
public class CreateCategoryTest {

    @Mock
    private CategoryDAO categoryDAO; // Mock DAO

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private HttpSession session;

    @Mock
    private RequestDispatcher dispatcher;

    @InjectMocks
    private CreateCategoryServlet servlet;

    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        servlet = new CreateCategoryServlet(categoryDAO);
    }

    /**
     * Test khi tạo danh mục thành công
     */
    @Test
    public void testCreateCategory_Success() throws ServletException, IOException {
        // Mock dữ liệu request
        when(request.getParameter("categoryName")).thenReturn("Đồ uống");
        when(request.getParameter("isActive")).thenReturn("true");
        when(categoryDAO.createCategory(any(Category.class))).thenReturn(true);
        
        // Gọi phương thức doPost
        servlet.doPost(request, response);

        // Kiểm tra xem có điều hướng đúng không
        verify(response).sendRedirect(request.getContextPath() + "/dashboard/admin/category");
    }

    /**
     * Test khi tên danh mục rỗng
     */
    @Test
    public void testCreateCategory_EmptyName() throws ServletException, IOException {
        when(request.getParameter("categoryName")).thenReturn("");
        when(request.getSession()).thenReturn(session);
        when(request.getRequestDispatcher("/dashboard/admin/createcategory.jsp")).thenReturn(dispatcher);

        servlet.doPost(request, response);

        verify(session).setAttribute("errorMessage", "Tên danh mục không được để trống!");
        verify(dispatcher).forward(request, response);
    }

    /**
     * Test khi có lỗi xảy ra trong DAO
     */
    @Test
    public void testCreateCategory_Fail() throws ServletException, IOException {
        when(request.getParameter("categoryName")).thenReturn("Đồ ăn");
        when(request.getParameter("isActive")).thenReturn("true");
        when(categoryDAO.createCategory(any(Category.class))).thenReturn(false);
        when(request.getSession()).thenReturn(session);
        when(request.getRequestDispatcher("/dashboard/admin/createcategory")).thenReturn(dispatcher);

        servlet.doPost(request, response);

        verify(session).setAttribute("errorMessage", "Tạo danh mục thất bại!");
        verify(dispatcher).forward(request, response);
    }
}
