package vo;

import java.sql.Date;
import java.time.LocalDateTime;

public class GuestbookVO {
	
	public GuestbookVO (final int id, final String name, final String message, final Date createdAt) {	// 방명록 항목에 필요한 코드를 저장 및 제공
		this.id = id;
		this.name = name;
		this.message = message;
		this.createdAt = createdAt;
	}

	private int id;
	private String name;
	private String message;
	private Date createdAt;
	
	public int getId () {	//getID를 하면 id값을 반환
		return this.id;
	}
	
	public String getName () {
		return this.name;
	}
	
	public String getMessage () {
		return this.message;
	}
	
	public Date getCreatedAt () {
		return this.createdAt;
	}
	// get 코드 전부 위와 동일
}
