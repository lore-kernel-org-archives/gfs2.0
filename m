Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422239;
	b=MjJvHUnty7GXZqllE9BFtF5K2K2DqR07FaQcw7mOC80gtt0z/iQyZ+68GSpHReBruS49
	 i3i+y7bjUpc3WqdJd8R6pmVVR53o27y+Ev1qLjZQvWnWF7KttQT7PB9dq9oyQVbgJTwsM
	 8x7fwOjYpxlxRX6vw1e5BWT4czNwLAqk8sOxPNlWynv8x18SbwgnwmwmuM2IJjCca1r3i
	 B7U9C8+X3hu88P8zNbOFPa78aNxVZQkEE/Wawkvxy+kGhbaewVAdwTh3r9pLXTLqOZz5m
	 MUwEr9BVpp39qc18LUJJQtei5lpefAgAx1JwQAJ64TWaF4/Z52wW9uHXhNL6bRzIeLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422239;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=E/F9aPQoKXfrKQaypE4bbnWX3DetVkwn7UCBCBTDXjQ=;
	b=IOfqIa+/StCapyA5bGUX+9SJcgSYdH18Z/qg4Y40/Q0H0wbmqsj5xzRLvDgHzA+U7+Ue
	 yj1uZ1owee+DJwd4LK0SojlXQLezOKY+9r/xUxLdoFUmFFm/0OImeNqqUGU368ToTcRTJ
	 ahMLn+mSCSgTGg0lhdxHVoces2XQVjayR8bPnPgWrFr83kfuINiqPJc0bgaziTlkKP0Bo
	 b4GyZv5I21acYR0kUSUMMJjLkzmE5i/WQ5YNikx4IdWPKaQj0WQUIcgLLFTx+dAndgyuA
	 E61mIdjadFMc3rumeirx4dSTqGX0cDPot+0GYiqpR/Vfmta7aDAlphWWU+IhWBsyVgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=NUMV67UW;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270F606A31A
	for <gfs2@lists.linux.dev>; Mon, 23 Nov 2026 08:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C270F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=NUMV67UW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795422226;
	bh=E/F9aPQoKXfrKQaypE4bbnWX3DetVkwn7UCBCBTDXjQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NUMV67UWs9t18N1OIM4ZtUr1G4KUUyxlxQY4jj2StUUgrdfoqQDTi+/hY079+OY0J
	 OnVGI96JbaGtvfDqiSeE6UMz2sKFebG+gKu+BCHNHj23ZL7vOoQPmmEqMWNRGdnm7O
	 SxeosppPti5L8UZgKbXLnhj1omBx5TnVbELEq3yg=
X-QQ-mid: zesmtpgz7t1795422219t18ea3391
X-QQ-Originating-IP: PVyhqQzatqIPjVoEXm47QT9VjeoAIolcwI+N8CJf7k4=
Received: from PECI2040 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Nov 2026 16:23:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16570581694892023629
From: wangyu <wangyu6@uniontech.com>
To: syzbot+cff8e1b82d7911dd051c@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_remove_from_journal (2)
Date: Mon, 23 Nov 2026 16:23:37 +0800
Message-ID: <47E6766CB31C3F0F+20261123082337.77430-1-wangyu6@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <6978bb60.050a0220.c9109.001c.GAE@google.com>
References: <6978bb60.050a0220.c9109.001c.GAE@google.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NZcrde3zhHkVVrVS4xNBkTmMJlAdrg9SQkt0SNLUzZqn0V2siwX7de1z
	L4PLAmNOmKAR7ZEB1DgHw9TbkqBaSg+V7/2a473dCT+XZ5ff62FA6Jzox+p69HbiSUGsm6h
	AH7gloGSQxhQbTHlSHvJQfi6+ghvoHwvOE0hdGOMYmZq4L9lU7As82NbC8o+HfJNUnFzfPB
	37lcGN3MmKHz7moro5nCsTHMydaFu/cZg3q3z8vJFvTvkVRqBbQgaKuwIBkYj19Vm23IJVw
	p2vLXKJOEg0Rq6skTRwNlWXcnpJcLlBfC3Ah7929Mq2hdqOkfExNa1pwXtgG7TqOIj76XL9
	vLrFT8ul6tqHb6kkSlSe6Q+fViqgvBxVqJMPyiHxZpyu5cR4D2KAy+HhzYj/BZsHT7zp2zC
	7vKskmGKs3mhF18V7oEhOul44eXD/zbThsf5DcRifP6rlocZQo2X1aNiyfapL3Fk/FM/pBb
	/c+TXDYxfMjbWQF2RMUv9fBG9ejDS64zCS5NcaDhLE92LrWLqm429n8mMuzrxbXwpag05Ik
	F7f5L8DzQkYoRFeDONoaI1Az/LZRNhK8Fvj4EVxuRFj3SsO89yG+vtoHXIbH8ukruinoV1A
	5HQr0uqoXhLf2dM1ddLxJh3ZlB6JpecJcFH3Ffm9ZSyNXNNNTuuRIOZtzOZrIvlANZNQbVD
	IcrSTeKewHJYJKOmsyLW1h1L9Q+P5APVjVpcrVFjLDUW8uYsG238KCLhs58+s+G5VfP9o93
	FNFVM6HTy+J85rqosKa8MDuljfBpYJ0I9hTLur52J8U4ZeZF1k/ABtD+WROGS+6tz5sS4b8
	g3yxj/8KHdo6YW0SJ02dV2yTvkMT2tcY0Z02QqS65VHcyKfnpHQ5xAGfYLBp4imw3nOnnyF
	PLD4HpPG7gBp5s65lpLdgMNMgibjptyW72SuTCm9zgVXGyl1PcW6ZTzFxbhrTVtwh2l3FYH
	PvpwqsiZCBnHJs1Lr0JyblMIW6RqHqMzpHtLs9UOxGWN7DssuwvSyYqOnVj95tMoMXuD4x1
	f8eQre88bEEaDULD+YMHn4XMVfkVE=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

#syz fix: gfs2: fix address space truncation during withdraw
