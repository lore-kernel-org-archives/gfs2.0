Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F42154BE5
	for <gfs2@lists.linux.dev>; Fri, 20 Dec 2024 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734678892; cv=none; b=VajJbbO2GllLKcJ4MFWbvD8hyCb7hUFQrJAPHklW5H/sZNSo731w/vDUOgmmbTgMTyHrqLHu2PlTufDz7xnJBPbWXRjoATZzBq6vbCbEiyHiq9+sO/mdMNCeayDrzhI/sQrY+0sfQ+4d2YTM92CeOiUj/vgvdrK7pgLdR0szH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734678892; c=relaxed/simple;
	bh=JZBt14WbRSakTclmkKgoNCBh5hqMFr9PQyqYSJqlb90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2X3WoPmNr02dkJxYu5P5oFAVycVdc8hUi+NholfgrTgT4cMfD1oKJpgeKrGmY/l1X4HGgS+0eiY/57Yrx/5vKlmUCtWja2cH6SQtMeh7hD+RiWRF7t30ybNnGYbHBVH4ISZbhVhUgb9R9xl/7cgcH/zM2ouTf+wIBVvhb6zDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U14h78mN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U14h78mN"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3cfa1da14so270739a12.1
        for <gfs2@lists.linux.dev>; Thu, 19 Dec 2024 23:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734678889; x=1735283689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xoFCorcWTs5xAV2D+SIy+/zhRYtjpjFGS95bOSDRWZU=;
        b=U14h78mNsy9uIxNKS/I8HugsPnjl2WRob5vUrmEVdtMR2WJD8+mehWHQsqZnquxJPk
         aX+F76jmSEY3d0WSbR6X28OvpzJej4YRx8wZu/mMn4d0du+dQjrYlE2X1/h/h+cTiMv0
         SDAhdasYrKXXT0EvcRChnZeVuhUldr1B1iI3YF0/ezhDILDI+09hGGlrJxknz52xRpAi
         BEWh6GNWkJH26L29pTHEEFb8s6G7/Rpp35O/LBtk2Wh7F5tUQ7jHJax46hS3cAehvpi6
         wHY2L7fqFC1F1K3om+ZaWRAjh9y/XwzGxXAh/f+hLEiC6jbw9v+EJuivQPoofHgCtqxb
         wBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734678889; x=1735283689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoFCorcWTs5xAV2D+SIy+/zhRYtjpjFGS95bOSDRWZU=;
        b=tiXVEDJ8WbS5g9o5dmzb6LCkoP6AA9fx9fw1mNDa1YjbvR2wRdLKSDsUhCZU1iYzHE
         68/+nYXfzsNMN5nqZj6kO8unxFqyVdWvfBiyzj/z8hdoOr6rEqoogpnk0QKmQZWKv4wB
         qOdLH81k21HKztexR9FF18b+xdZtbUwQCtjMpdDsZRSrTkwoLVhPN5sCIWB+QR7dVptM
         ghp/7MaNlFZziUWv/ehnrQp1v/UrvN091+/X25iXyloCT/Ed85nE7tk+yY75lMbnXMEG
         X7HO9nFa+T6Vw3lcwZaGCfmRrsvE7WWurP5xYJUHnPNJKMlQxnwmGEMHPd6Er92UluN5
         jXlw==
X-Forwarded-Encrypted: i=1; AJvYcCVfdnxAENVXE5Q7yiykLqikifgtCHmnKl7bVbO6TpWRqoo+p0svwVQcGJgr15meoQhD5Cil@lists.linux.dev
X-Gm-Message-State: AOJu0Ywutn3zRsnPYA0pLhSpVkdXdfQzr2jH6c+52D7tHK7Mi+WWb3We
	MGHMmen9ICauOvEST3p5dN+JhKZilgvuSPoeuuGNkkoBo1xl+h+sXw4+8aETSb4=
X-Gm-Gg: ASbGncsRCbt7F8be727uf+xsOWhISjIMNsKXYvhuxt/nVGPiiVZPFyoPV0L2OjkrX+l
	U6Ls9oTwFUmPV8dy5crwzX6B+HjdTGk/xRh/qtUCSUGiCz0FzNfRpqR3rzNLBUs6mnrpDfouKkX
	kX0B3cfcNds6HC1rHonz7u3Q8cZKX0aZkZMDVrc3W6WpwOw9EdfwCggsC4Wt6gE9dQWKwnz3SuN
	JtqaLkH5eY3Ery8+l6a7maIa8Iy0B1nVA+us0jZIKDabRgKx0kubDe5tC03QfDyC2dnj2Y=
X-Google-Smtp-Source: AGHT+IEzD5RQkvLHC0C3vsg7dTvfpE4zTTEjfxLGR/yUBD42OFzNNFyL+eBdF/7Z9CmRlB0ogko+xQ==
X-Received: by 2002:a05:6402:5207:b0:5d0:d786:b87b with SMTP id 4fb4d7f45d1cf-5d81de1fda5mr404078a12.9.1734678888642;
        Thu, 19 Dec 2024 23:14:48 -0800 (PST)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc97432dsm22817355ad.110.2024.12.19.23.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 23:14:46 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: teigland@redhat.com,
	aahringo@redhat.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	gfs2@lists.linux.dev,
	ccaulfie@redhat.com,
	jfriesse@redhat.com,
	nicholas.yang@suse.com
Subject: [PATCH 0/1] dlm_tools: support corosync3/knet multi-link
Date: Fri, 20 Dec 2024 15:14:38 +0800
Message-ID: <20241220071440.16803-1-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is to support corosync3/knet multi-link.

btw, this mailing list (gfs2@lists.linux.dev) is the right place
to send this patch?

Heming Zhao (1):
  dlm_controld: support corosync3/knet multi-link

 dlm_controld/action.c     | 31 ++++++++++++++++++++-----------
 dlm_controld/dlm_daemon.h |  4 ++--
 dlm_sand/sand_internal.h  |  4 ++--
 3 files changed, 24 insertions(+), 15 deletions(-)

-- 
2.43.0

