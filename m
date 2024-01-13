Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF1963C3
	for <gfs2@lists.linux.dev>; Sat, 13 Jan 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzV758I3"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2d348d213dso23081566b.0
        for <gfs2@lists.linux.dev>; Sat, 13 Jan 2024 01:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705137752; x=1705742552; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M+V85uRLksejE8DxNWfVy0uNoQWsnDroqx7Tft1ZGvw=;
        b=SzV758I3lszTa0ZZY6YWPdtg+VLZLrRXbP9Ug2QqQ8pZsn4uK35gzWu8yp4ar5DU02
         tEtaNGPJQWK8JG0F1V4iRomTI25zyafIQARdWHLYL5fPZRRaMmdvfuCxL8HMTjxYCyN/
         pk3u5aVM/3SIjQr1CfGXQpiYSOiMbe1JQqycfvEZQONwEHVqW4Va9qAN7tVQLXOtMb3n
         p6TMaTF1cGyFhTLCXw6tl4FS/LLFk+ylOJ0EGkegyVrJU8TgQlc2cdBMMf+L6zKPMlpZ
         ZdDHVZlfUouFWsWCuCSpGrHZk9TRefPoFgqa5fqXt2AYLfGOVWxWhLd7Gr6XlSl0LWN0
         cvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705137752; x=1705742552;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+V85uRLksejE8DxNWfVy0uNoQWsnDroqx7Tft1ZGvw=;
        b=vVcNvHSP5Sm7P+iCuxEXpvCVq00m5f3tzKbF4DjvU9rKQoRvivhYF3dNq9sqtjc73p
         Qp/CpbsAApJBCBzWeiytO6GJMOmF8jpSdbFprpYfNIOtdBLbTkWWKwSY7hThXXiZBvkr
         73fdwRyYJGiw19JTq4ldviym/0kag0LmNTajCKzBWQ164D5D32bIE04gxOsbchVoHVc7
         wDFvkfwgH0XtQyQtdHiTx0Ko9OXblBINNn9YUJ6TTitblBvziMGYsfshJeglvY1OAEpf
         GLVXWXYdaUJnYY8b+0QZpsYXBt5/wIurKrNM3AmKBg2f2e1Tca6FudYQRl7xgLy2+Hmb
         RW9g==
X-Gm-Message-State: AOJu0Yzltj7GkOkU9Xbk5/Q8bniP0o9J2H+098XTvbxZrcUc7EXg3xH2
	4/+YXwqsSl09qh8F/ZzgojvEhXFIo/sYMtuDvdghxlRt0/0H+OAGo2I=
X-Google-Smtp-Source: AGHT+IHwOGZ2woO6QpPMea2SumSWTXDHcYtaNBxNzItsMjZ5trKKYX6zV7/MvkWtwAe0auacT9HOE8aYLdaxHcLYTLg=
X-Received: by 2002:a17:907:a805:b0:a2c:4ce0:7a17 with SMTP id
 vo5-20020a170907a80500b00a2c4ce07a17mr1613707ejc.80.1705137752191; Sat, 13
 Jan 2024 01:22:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Mehrdad Dashtbani <mehrdad1374.md@gmail.com>
Date: Sat, 13 Jan 2024 12:52:08 +0330
Message-ID: <CA+sT36sN+q6+a9JU4=ZLDVhcw+B6+YV4AE-MJZu6wNiXGssN6A@mail.gmail.com>
Subject: fsck.gfs2 bad read: Input/output error from lgfs2_inode_read:51
To: gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi, everyone

I have a cluster which is using GFS2  for shared storage.
Unexpectedly, an I/O error occurred on one of the cluster's nodes and
unfortunately I had to reboot the cluster's nodes. After everyone
booted up, GFS mounted successfully, however I/O error still persists
on the exact node.

Then I tried to resolve it by using fsck.gfs2. So storages were
unmounted  and fsck was started to recover the filesystem.
Unluckily, in the middle of the recovery my SSH session was terminated
and so was the fsck command.

Now when I try to re-run the fsck.gfs2 again, an error is thrown:

bad read: Input/output error from lgfs2_inode_read:51: block
288230926779940864 (0x400008034000000) count: 1 size: 4096 ret: 0

Thanks,
Mehrdad
