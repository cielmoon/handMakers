package kh.hand.makers.admin.model.service;

public interface MailService {
	public boolean send(String subject, String text, String from, String to, String filePath);

}
