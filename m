Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710601C4616
	for <gfs2@lists.linux.dev>; Tue, 26 Nov 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622925; cv=none; b=myXLxgMShAk6c/updiQLjIJeRbbkVSZLRVEXdgFXxVFKUoDkBTTrfUbvP3+L5SL/CNmMHPKTl18bRMwHTX+LJoP+jPm2FaH+YK9C1P6868mRVNyC/vDoOM3uVpvlW6QY/FLJ99qcGRDO7ohkHpj7cNeL4ovc+4sWKsjbgUmnhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622925; c=relaxed/simple;
	bh=w3DNd9eZFiFuVOjSFy+tRo8pWFg9wCa5VYTvMm5av0s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=An95ffChFAr4a09C03WtDI1qKv0u7/7/dA/WUix5Jlj7Uy1gfbYA0nx6IvO+zRCJWROZW759YIOt1d3IoPOw7oKU6NO0SI1XMDvyqNMn2sfKxTxnnVUkPk4B1Tg1FMDwJELTdHtnUfGYuOPjyFCRkXnQQq1NB5UM4AXhjjXvihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmQzKMQQ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmQzKMQQ"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ea5120dd60so916395b6e.1
        for <gfs2@lists.linux.dev>; Tue, 26 Nov 2024 04:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732622923; x=1733227723; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8c62/I1cZlNPbc+p7CcBCcDlIhP6BtucEE7bum66MKk=;
        b=XmQzKMQQJ3uOAJo07XaVr8bq32+oBMARSGgEvySZqzN8/LWzHSqWvRH9YlSXCgKfYT
         sL8QQa10syT+prcVUuEIQ3IdC9+hvf+DDGH4INmN8PP4GzKjKuEFprXyMi044O7ygQUK
         NFMl0vafT2hgw3r5yQAXA0rS+xEjS3y7jOfxr053xcux9zMW8kdtxlJAPE6Tz87l5uYW
         7UU2WQ8J3gOtOh+vAmq6zlFCg4vQu1EjAxUK13z9k9sgxtcjJxVCtt6di772+dZd/+US
         q1nqHcedVnXf4+Y02Y+sWn51MSxrvuthjrIOTv8PMAI6mVO9W9YEy2bX06ZVyJFxjHQi
         aXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732622923; x=1733227723;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8c62/I1cZlNPbc+p7CcBCcDlIhP6BtucEE7bum66MKk=;
        b=ut9qe5Z7c97HkDrpQuCvxUDRBrPFJwgemEhz5B3xLcl1wsKRodEuznIZhzRLv0i+8B
         1UcgHgsrFFd4B+Lmx7+PRmSsOyjNAMysz5AtSa8eyS9z8i9bO92oaU51Ync3iLc16rmC
         smLY0IytWnfDIrP8tCMyi6tsze9S/Hu6ympcY5eyLKUh1CvyjniS3wKiH6iNcjGMllKT
         9j2oUJKFogxy5WRZS5rO7THejRiftSKwKAqgTzw0ZZpgs5tNIu9Sh3FCr+I2+qPYcdVP
         mFQ2+xFvVO74TjgoZDKH3TNX/VQdICxCGevR5Ymonbf4B0XD7ocfgXenqKkH7t5VSN2W
         GHYw==
X-Forwarded-Encrypted: i=1; AJvYcCXmiANf5HRY83u5AR+93ocbQjG6aWoAWfCP/tolLVd4G0wSyrAB4LxNjt+E/ydB+4Q54g4s@lists.linux.dev
X-Gm-Message-State: AOJu0YyznmKfSRqYcD9YNGya9M+Lzyy6V4jZhGlj3ddW1xTeKJxOaL1S
	hIr7oI4b2PiQl5Jzoltx4hKq+3uY1lUjMN2gq5iUCgmo58Cn/TT6oqeB+HSe1hYTO1oDFQzRY3Y
	gHJsaGX/4f8yPwsKSPu4SH+8Tuho=
X-Gm-Gg: ASbGncvG+7SJv4b6bkLGuZp9deKYfnFA11d46d4GunXA85yuHt4G98CSqz26I+PRmVI
	HQHFL9r6bsG4rdpdfaG7X2FUpOHnDdU0SfJctkfHo1g==
X-Google-Smtp-Source: AGHT+IHgDiX+piy7PZ5AEYr/oQBwsQLhiVS+gr4VGtihNr9dakVFBM05UiN2LDKDVhiZjy2bcGhdxcZcU0XfYQVNsT8=
X-Received: by 2002:a05:6359:4196:b0:1c3:724e:f4d5 with SMTP id
 e5c5f4694b2df-1ca797cef6dmr932506155d.26.1732622923239; Tue, 26 Nov 2024
 04:08:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Zhang Zhiyu <zhiyuzhang999@gmail.com>
Date: Tue, 26 Nov 2024 20:08:32 +0800
Message-ID: <CALf2hKtQH9KFp=KDQo6jmq4jpNzqoJnJRAFKWHf=Tk62U6RaVw@mail.gmail.com>
Subject: Follow-up on Linux Kernel Vulnerability [v5.15] KASAN-stack-out-of-bounds-Read
 in gfs2_file_buffered_write
To: rpeterso@redhat.com, agruenba@redhat.com, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Developers and Maintainers,

I hope this message finds you well. I am following up on a previous
email I sent on March 3rd, 2024, regarding a stack out-of-bounds read
vulnerability in the Linux Kernel 5.15, specifically in the
gfs2_file_buffered_write function. Here is the link to the original
message I sent to the Linux kernel mailing list (but forgot to cc
syzkaller group):
https://lore.kernel.org/lkml/CALf2hKupR6mV4vUW8tWEJY_1CqaLLrqx5q2667XGEzEGnAtuQw@mail.gmail.com/T/

In that email, I attached a detailed analysis of the vulnerability,
demonstrating its validity and potential impact.  I have noticed that
the issue is still being triggered on the latest 5.15.y branch, as
reported by Syzbot
(https://syzkaller.appspot.com/bug?extid=43147f1cd55d15dfbf7d), and I
would greatly appreciate your insights on whether this vulnerability
has been fully addressed in subsequent kernel releases.

Additionally, I would like to ask whether a CVE has been assigned for
this vulnerability or if there are any updates regarding its
resolution. I also want to discuss the CVSS score for this type of
vulnerability, which seems similar to other stack out-of-bounds read
issues in the Linux kernel (e.g., CVE-2023-6606, CVE-2024-39487,
CVE-2024-46743, CVE-2024-50227, CVE-2024-50301), all of which were
assigned the CVSS vector:
CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:N/A:H.

Thank you very much for your time and assistance. I look forward to
your response.

Best regards,
Zhiyu Zhang
