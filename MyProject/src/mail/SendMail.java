package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SendMail extends Authenticator{

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("vardy0117@naver.com", "fm3255131");
	}

}
