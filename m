Received: from mail-m8221.xmail.ntesmail.com (mail-m8221.xmail.ntesmail.com [156.224.82.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D023F54D3
	for <gfs2@lists.linux.dev>; Fri, 24 Apr 2026 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.82.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063947; cv=none; b=O32T4MnnALt2tPqDFeMI06ZhZ9w3CEw7Y4iOxPY5GZOFDC8JQ8DJyzp+cAu071WcAeYZf0sHyYHJUzFjJnO2E38JPItdnM4krsYGaYzzubr7iUp5CtO2xyu3Vcvk4RfAq26lY9LWf+B/Wsl/lYrWREujq9l2xFH7Vmm7DuLnxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063947; c=relaxed/simple;
	bh=uzVua+V4FP5/GUJ/Tncf81zDLP6aqQ6bBdYUSdFz574=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XH/zD8/CHVcVPGzjLGzOPB2mF7zzOefnR5URkei9NgPhLqsBr408NYSrj0hW0QtcI88GMKYByL/LZty+UpN2m7qKG8zDRhvBWF1zssa5cQvltcQhvQMvPzYSu04coQ5zhJJDmPF9NH9CFXZiToTgA3lSMppTWrFsOiBcdM/bj10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=f8hQaqk8; arc=none smtp.client-ip=156.224.82.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="f8hQaqk8"
Received: from localhost.localdomain (unknown [IPV6:240c:c001:1:2e07:24a2:230c:7edb:52d4])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c147fd05;
	Sat, 25 Apr 2026 04:52:15 +0800 (GMT+08:00)
From: Wxm-233 <2200013188@stu.pku.edu.cn>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2: keep per-bio end_io when splitting journal head reads
Date: Sat, 25 Apr 2026 04:51:30 +0800
Message-ID: <20260424205130.686-1-2200013188@stu.pku.edu.cn>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <CAHc6FU5C-qu_mtN8FnXy3nY_jnskDr2EQqESqCrwU4MrDy9_VQ@mail.gmail.com>
References: <CAHc6FU5C-qu_mtN8FnXy3nY_jnskDr2EQqESqCrwU4MrDy9_VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9dc143bc3403a1kunm4794f96f64dae
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQkwZVkwaSxhJT0wfTk0aT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0sYQRhLS0pBSkFJHktMQUlPGklBSUhLGEFMHh8ZQU5JH0
	9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=f8hQaqk8ARMtIRqzjMXLMUdqA/NFl5Ay3zq5qoR7m/j8ZB5sIu+Wk+L4+Rr4FtDdrLvU9CzA3moNwKarxiamnfyv+RxKgA+k6O8mVITu/kr7oC/1OhwTHWc4g6ruRm2P0dJhmx2rwCEmXNXwG2vPeNLfu/Qk4pWjHQKlAOoWG/g=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=9sOrqAkWYQcCR51xw8Ny9D9oCO0KmESkW9m9XzhlU8I=;
	h=date:mime-version:subject:message-id:from;

Hi Andreas,

Thanks for pointing me to commit 469d71512d13 ("Revert "gfs2: Fix use
of bio_chain"").

I had missed that revert. After looking at it again, I agree that my
patch direction was wrong, so I will drop that patch.

What I can say about the trigger so far is:

- we reproduced this on 6.18.5
- the report came from a syzkaller-style fuzzing run
- the crash happens during GFS2 journal recovery, not on a normal data
  path
- the stack is:

    gfs2_recover_func()
      -> gfs2_find_jhead()
      -> gfs2_chain_bio()
      -> bio_chain()

From the code path, it appears to happen during journal head lookup
when the read enters the split-bio case in gfs2_find_jhead().

However, I do not yet have a minimized standalone reproducer that I am
confident is correct. The "last executing programs" section in the log
does not isolate the responsible operation reliably enough, so at the
moment I can only describe it as being triggered by mounting a crafted
GFS2 image generated during fuzzing, which then enters journal
recovery and hits this path.

I will go back and try to extract a concrete reproducer / test case
before following up further.

Thanks,
Wxm-233
