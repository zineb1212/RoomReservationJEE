import java.security.MessageDigest;
import java.util.Base64;

public class GenerateHash {
    public static void main(String[] args) throws Exception {
        String password = "admin";
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes());
        System.out.println("Admin Hash: " + Base64.getEncoder().encodeToString(hash));

        password = "user";
        hash = md.digest(password.getBytes());
        System.out.println("User Hash: " + Base64.getEncoder().encodeToString(hash));
    }
}
