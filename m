Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E81237160
	for <gfs2@lists.linux.dev>; Tue, 24 Dec 2024 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735029772; cv=none; b=L+7mN5lBRitqt0zjbG9x3gkmhZm1yuj6B+SuKqhFTCgJ9MUfLJeAOX4s0Ub3QQlZKgwf13ab90lL4+ztKHIe7gwIroYe6yxz+MKZhi+WXZDLLoag8w0AS/kBrS3ybcHtnE3jH68mx68gAfKoS3U4ArKEgJqDx2MZjEJnwUn5FMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735029772; c=relaxed/simple;
	bh=mKqUBJiWBM9IuVOA8lEPQ1xzN37x+YUTxvTmCLA1OEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROcWj5jg6E9hcq2gbSNoT10dfe3vS33dQkBID3gIZXrmPgY0YQYPTbBe7YlhI5HlY8U5+Yo/We8A1Fhp7J1Xg6hzN7Cgu6Y+AXCokhvwDuPGu/eLUxjcSkUgifGX9uP87hS0yHQSRHuj1yoi6TXbt7wmPo8W33iaKCJ8YGy/Qvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eFohpQjh; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eFohpQjh"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e5c225aaso876615a12.3
        for <gfs2@lists.linux.dev>; Tue, 24 Dec 2024 00:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735029768; x=1735634568; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y5x9FD/Piyc4ekLtSU8bytRkXxw529CjaqPeNJhsJA0=;
        b=eFohpQjhgrI2uJegcJPH23QEQ/gjkQv1v+wVlIKak1xvUcvtgrmKg/U8WIAAru4ycU
         uIWPIHPR51zIFsi8VersSSRQJgcuopTo5wTNM29cU0TPh/cgu1syUxTf0YNIVKk1laTn
         6bNqNzyubRectbtCIW/IItzVCYv+F7K+6bLq63iscXQ4pUGK7/rvLlFgQAn2e1Dj/IUa
         mNgytx8Rf0NzZEPzxbdjCudE/jX1/6OSfzH5Fpe1fdxvn67Nf43a9NJGCL84JLSSFr8q
         TgJyt65jDnjXsrvhXbAoEh4eLxKk2frWYnWygJgHdaaHbBXEH+tJ4tUnskwXsn2CCknL
         ywNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735029768; x=1735634568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5x9FD/Piyc4ekLtSU8bytRkXxw529CjaqPeNJhsJA0=;
        b=BgvXlIGI+76lkoN6zZrhRBDshovgH0/B1jSr/i5p7GlJSRYk/sDb8FxKw6FtEKFYAj
         1wLSBx5883HXZXcKBNvPzTTLXInpWxWd2AR441eprP+XIvt8Vd0ABDBMXlPxCTNjVfcB
         SIZHw/vjzZKJWrTkz+9iMyCl4yIEjSCSxm7G759W8cXa6KOEtJ4jWXeVnJA4e/ZtWxhK
         mcklBYBZT37jkGVUrtUat7F7rtprgbyjnyIf6Ywez7AYfk91ybX8c+veVVNmCci4hvXX
         m4alCATophH+zdvX53OTrzaJad1Tn98NfVGZJvbJEmelow5o7zqSH+gJwRZhKPU1r5Dr
         kUPg==
X-Forwarded-Encrypted: i=1; AJvYcCWKwezhiz/29Szjr1vi3GH8P1kjoUDwejSwTfyMJoRp716oEAi4xiD1+DMNSp5ctigooSZF@lists.linux.dev
X-Gm-Message-State: AOJu0YzqstR8RwvGRRbEZUC9oKvFPoV2MX4fXrNSlipBX+BkInXEeh5A
	+4kV9KkFreMHMkfJ+Is4GSEKS2F1IteY2hl1d5UCMH7A4SH3cgOJ8uLMDPSoDlo=
X-Gm-Gg: ASbGncvBzw/L2ARdqRDLdRkk0i1hW5Y8xn9NwTz4gdB5spMjmbfo4M6DyTTsfCyEr3c
	hzkkHGjfnMNSptRWpIvSvs/xyyk4/Uesa1wHqLic+7Tz8XDBdr/mHRKRhBJv+A5R9h3qyjfdE4W
	4OcGVNLBdmCW937lKNLGugOQvq4OCW4KfT927xQjFaYAUJNQxeoH3vhRiNM87sdZg42oV+L82Ba
	ap8R/Y8tBUJlrcI1ixMShD6zSsDiGa9gL4tpHb1bRkSk1K7RpZtg8b/eg==
X-Google-Smtp-Source: AGHT+IGckPu5F9ycVJ4kSwPne1V2k/BpBohVBH33tloaCor3X3rKSrHPicD5Rllh+ALG4G7GDfhymw==
X-Received: by 2002:a05:6402:51cc:b0:5cf:cc32:82f2 with SMTP id 4fb4d7f45d1cf-5d81ddaf985mr4404735a12.5.1735029768511;
        Tue, 24 Dec 2024 00:42:48 -0800 (PST)
Received: from p15.suse.cz ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba73184sm8494332a12.17.2024.12.24.00.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 00:42:47 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: teigland@redhat.com,
	aahringo@redhat.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	ccaulfie@redhat.com,
	jfriesse@redhat.com,
	nicholas.yang@suse.com,
	glass.su@suse.com,
	gfs2@lists.linux.dev
Subject: [PATCH 0/1] dlm_tools: support corosync3/knet multi-link
Date: Tue, 24 Dec 2024 16:42:38 +0800
Message-ID: <20241224084241.13563-1-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is to support corosync3/knet multi-link.

Changelog:
v1->v2: Added new code to support corosync2's 2-ring mode.

Heming Zhao (1):
  dlm_controld: support corosync3/knet multi-link

 dlm_controld/action.c     | 44 ++++++++++++++++++++++++++++++---------
 dlm_controld/dlm_daemon.h |  4 ++--
 dlm_sand/sand_internal.h  |  4 ++--
 3 files changed, 38 insertions(+), 14 deletions(-)

-- 
2.43.0

