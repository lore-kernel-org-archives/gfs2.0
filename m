Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BCC154BE5
	for <gfs2@lists.linux.dev>; Fri, 20 Dec 2024 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734678870; cv=none; b=HbpI/aMvU00XQzM1neadA9v1G7/gXWnnaRXZgA/BqBR6aq+em4Y8JiVtuZYdfDk6QeCUkklCXGUj0LU/fw0/AgwuW4hQO+y1P3edg2zXsnWLho+HFgXC1kdv2ME9kqcegVWpqBlzkU68o4dVkvBP91OrlOMdv4iBJFT7/DQy99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734678870; c=relaxed/simple;
	bh=6LgytrX3lXZgySAZWUT2S8c3GUdMdcnOb/prH8vdeZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKWi7bLqcDvYPymr0y/1zgdxCjp0k7EoWN80QNj0GbTSHH7sHWflKUuECMCyZehMRyLfODv37IviCU+/VRQC6orll3mcQF1m7VtCguMJcdfIcNHFNLzSbIa/lymZXg7ms/HNxI2yIJq+qFxpDtLhZNLVdVENAHGSc6HYx7hFfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XQRcDe9n; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XQRcDe9n"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3e5c225aaso289352a12.3
        for <gfs2@lists.linux.dev>; Thu, 19 Dec 2024 23:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734678866; x=1735283666; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ayM8iPG+Hp02dg+BuEapKOtv8CAQ82jh9dQRq7ZyEAQ=;
        b=XQRcDe9nGCcmSTHY5v2J59EVL9tp31zm2wawHiHh73c0ru6rVKWC3dOhzCl/Pm89Pm
         TPgoP4y7/zz0B7liwkszlmTMzKi5oRXsJVtsqxDIOZBUWA0krgLLnyyRMRRgyBNnqrkL
         bPZ12ld/Al9gTHUN0/8e4XD/ov+LDtDquEaisYoNMDGpUlicwrrQyli/t84joIgmLzoz
         lvebaCledjxFLxoV6XnJmnH8TBGSYdYRX+mxIy83kvxx/t3vbbm2psmY2KuvzqVDbqyI
         z4KcHbuoUNA3pmo2EWtRXc7COJo4bVZ/opUIdut4przJwV7LB9dU7EBP8hXi6GNGYgkD
         YkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734678866; x=1735283666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayM8iPG+Hp02dg+BuEapKOtv8CAQ82jh9dQRq7ZyEAQ=;
        b=F4pTb9Psa0aaLBrKxSAftNVIlFycZYQ7swIHZKadpaGYhHNDGCmaekS06JgEzKoi0r
         HgeGcwKIdCUktp5AhN6IL62MuvTE5IRXmO5FEBbKK0Us2kwZ7HnupIlxcR4RWtI97fBZ
         V5IF7qQQ1BkZTL/HEhMilxgrK1zkS1EqgXoHTNzSwJ6vCUwfuzZJhMwLc1sWJXuzCip7
         N01mBtvcEaZv/Nz3EixJx+xVbA7kifvvSW4XFuQVofw1FzNt7KTF3a0Mwj7hu4FBHX2O
         u90QVFN37iQYIYOS+AcwmMT/FCSzu4eg33RvExhKrj02OxDe8PdpZa1TZ6wuE2+NvC8v
         u19A==
X-Forwarded-Encrypted: i=1; AJvYcCUs6KTma7+YQJtYiSXbiTHwxVOQxCldCPgAUdF6hV6yjnVMBWbZK2Bvhcdj05IaxsFoGRbR@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5223gvfHx1ZVpdZXnnCE4lZyhmFZKQtd67mKhHPBObGT8W5/P
	IaTJqSXPJK8kqbgRtTe8YrZ2CD/fPhGdCEsxodC3RqPWdhbTvJyud+FkKFxhMuk=
X-Gm-Gg: ASbGncvUxGLUMfrM0RcHPTMafWfUjo3ptIYAVl6sh2fbbTiikb/kO/eAqmATPa5Zsgf
	PKcj5EDtINfB2TQAaDsHTsTZWJ7IZbWnKcwyO9/0K1FTzxu84scqnHiq9aKnTdzrriTNpWTi5C5
	fx1BXtUf83/DW3QTS6+1BuOZpikSHsHKesJrjHISCubXs/u2k8BHh906KyzBt8RQoCoB4b45jX1
	RG7LzudVDrOGsEiriMSd+G8ZUeTnvfsnqab+SQsAH0wlU3pH3oZ7dhMQzBk8Vr9Ih4E9kI=
X-Google-Smtp-Source: AGHT+IFjFODwXV1ZwV8t7LpsHwUFdswMoUoFA7d63uvNnILmauh5VCx95ykngPd4Lsy9LAV2RY9zGg==
X-Received: by 2002:a05:6402:3588:b0:5d2:7356:e0f4 with SMTP id 4fb4d7f45d1cf-5d81dd900ccmr538286a12.3.1734678865980;
        Thu, 19 Dec 2024 23:14:25 -0800 (PST)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06d9besm4499204a91.40.2024.12.19.23.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 23:14:25 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: teigland@redhat.com,
	aahringo@redhat.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	gfs2@lists.linux.dev,
	ccaulfie@redhat.com,
	jfriesse@redhat.com,
	nicholas.yang@suse.com
Subject: [PATCH 0/1] dlm: increase max number of links for
Date: Fri, 20 Dec 2024 15:14:16 +0800
Message-ID: <20241220071418.16786-1-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch to make dlm module to support max 8 links for corosync3/knet.

Heming Zhao (1):
  dlm: increase max number of links for corosync3/knet

 fs/dlm/config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0

