package controller;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import repository.PostRepository;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;

import java.util.List;
import java.util.UUID;

@WebServlet("/post")
public class PostController extends HttpServlet {
    private PostRepository postRepository;

    public PostController() {
        this.postRepository = new PostRepository();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        // 📌 세션 확인 및 `uid`, `fid` 가져오기
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("idkey") == null || session.getAttribute("userFid") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int uid = (int) session.getAttribute("uidkey");
        int fid = (int) session.getAttribute("userFid");

        // 📌 폼 데이터 가져오기
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String location = request.getParameter("location");

        // 📌 파일 업로드 처리
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // 📂 폴더가 없으면 생성
        }

        Part filePart = request.getPart("imgsrc"); // `imgsrc` input name 가져오기
        String imgsrc = null;

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + extractFileName(filePart);
            imgsrc = "uploads/" + fileName; // DB에 저장할 상대 경로

            // 파일 저장
            filePart.write(uploadPath + File.separator + fileName);
        }

        // 📌 DB에 INSERT 실행
        boolean isInserted = postRepository.insertPost(title, description, startDate, endDate, location, imgsrc, fid, uid);

        // 📌 성공 여부에 따라 페이지 이동
        if (isInserted) {
            response.sendRedirect(request.getContextPath() + "/post?status=success");
        } else {
            response.sendRedirect(request.getContextPath() + "/post?status=failure");
        }

    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.getRequestDispatcher("/views/jsp/post.jsp").forward(request, response);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    private String extractFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return "unknown.png";
    }

}
