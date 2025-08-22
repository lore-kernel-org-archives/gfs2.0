Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083B02EE61C
	for <gfs2@lists.linux.dev>; Fri, 22 Aug 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856275; cv=none; b=Qt7fLe41KRmXX7dMy+/zHfAAPV1n3se+Gfwgi4Zu2nkA1erlmXe0Fwt6YtajHNtV1KDlLvhqP4pZJHXwiF6oJk/W/IWDUlh1V0ZOSvDd8sf4Hyc+T3sHB7MzNOn4MLaDE+sEQksBp8BYjUeaT94Ya3cthDCD++FLoYdRxgvP4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856275; c=relaxed/simple;
	bh=xOBM7ju3LdH6fgM98uUbXo3mj/L+KLYzI6HGxA0Nrjg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jhLjaU4tEbYbvYaa9c1/rSC4dc0kLdi0URQAn06u2H7HovnpYu5bUGFVT12fhbf7J7AZUSDnN2kC12R9fV8SyJPfd0EIgkAorihpwjqTNkgKn27HxlicgATNJZVyGTSpt3Is+SnzFZZDG3j0vGsjHq6KbKnrZqodOn1Hn7BsAbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=NaIM+wfg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="NaIM+wfg"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b7532f3so3385058a12.2
        for <gfs2@lists.linux.dev>; Fri, 22 Aug 2025 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1755856271; x=1756461071; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xOBM7ju3LdH6fgM98uUbXo3mj/L+KLYzI6HGxA0Nrjg=;
        b=NaIM+wfgjCCf9Nhq0G40jIgs8YkB+MmL80q80ZSMpz/JcIvLXmFHFR0/wwKajanqSU
         tVcPgpnY1TXDLyAS1sdaP2PYRy6M/b+e0mVE6JU4sBzEf3GPKb9EvrIHdZY25N1DmBxW
         4PjRtQkqJUpvFh9bUzJ/xpJOuo1wmUxrGsb8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755856271; x=1756461071;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xOBM7ju3LdH6fgM98uUbXo3mj/L+KLYzI6HGxA0Nrjg=;
        b=WhkgicB45KslePQ/kd7IV36JotDi2d/rLHOBVGw76pl/4zK7IwHzmoTqrOKn3FU6GY
         i54xyCWL9uJzKO91rLn+VZiIU/+KsM2zrOzZeTfyaQGCv/H2DlWrplelLb6bpQziglqM
         0c7UFoZbWd1DiWouo3bqW5YXPHeoBgXsMuZ6JuYhhcb177Kyeg33D791PW/zASJeBtBd
         +IaiL3tWq4Nx51EMbzN0O1ucVk3unUyZwEh6e6Zr53cjqP4tr6RgaCIAUlmne5AJjW73
         gFxVmsxsEZ/vrg8a7pvpIK/x5/rREt/xxNwrx558JpAOi6RmroUxjS+0V+ApPv52GX85
         uNFA==
X-Gm-Message-State: AOJu0YxylAY5jAKz+Hz+zAdDtNSbHbW+R7qAFX0eAs2ZFOpr40hFmLnU
	A/SgF1TsQZDSnF1Eeg9sgZ422QdsiuLyYbO/SC/uNkmsXt5q+Dr54wsks8WeDRtM7lAovp8U7P5
	ashR6KiAgzuEFdUWsJQAR3m++luxkOHt6cu3kZoi0ukzOoO3/dRKHFsw=
X-Gm-Gg: ASbGncvAUDMB5AZaiaqaWYkKVE3ef+WqBRoXMOyd9A/lVWt9cD6lBX8nOYqXWslkIx5
	4RQwd6KFiSgT9CoqNMhXa/HkNAL4sDWQun2vYCvDMoXZa+UdWeJOunocmIoKR2hp7cWzdPUwROe
	Tkec1OUL5+7KGnLX+GCZWtOjCXF/W6pS5tQ9ILcw5ULTGiQ6smBqRalH2+54S1iVBDo6C3YDpP6
	AiqU2vP
X-Google-Smtp-Source: AGHT+IE726x9AQf/4iMVWB32Mc82pS1Z5dcSKNRQQzHrYV35l/8Jf9Ntq1R2i+0/2tv+t3JNMGy6ibtWoqC21eiDmqQ=
X-Received: by 2002:a17:906:4784:b0:af9:3f90:12a0 with SMTP id
 a640c23a62f3a-afe28fd3967mr226645666b.16.1755856270771; Fri, 22 Aug 2025
 02:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Mark Syms <mark.syms@cloud.com>
Date: Fri, 22 Aug 2025 10:50:59 +0100
X-Gm-Features: Ac12FXym1nPBXy0VyXotnkcF0PFSDNCbHxZbsqEbZJ7qdcugAbrX6vhCrn85uWM
Message-ID: <CAPYKksUjLP-tNuUCC2Vg7uZ9btE6yMkAQQ-7X332522s-jOXOQ@mail.gmail.com>
Subject: Resource group glock granularity
To: gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all,

Sometime back I seem to recall a bit of discussion around modifying
how the glocks for resource groups are managed, basically with the
primary objective of making the glocks control node to node
interaction and deferring node local collaboration to some form of
more local, and thus less expensive mechanism. Did this ever go
anywhere?

I think we in XenServer would probably be quite interested in an
approach of this form. We see a number of things, which are at least
partially, related to our workloads being a bit atypical. We have a
number of VMs on each host all accessing r/w one or more files
containing their virtual disk data on the GFS2. As these files grow
dynamically (they're qcow2) we can hit contention in block allocation
under some scenarios like start of day VM start up. Being able to
acquire access to a resource group that is being used on the current
node without a full demote and data flush would likely contribute some
useful performance and contention reduction improvements in this area.

Anything you can point me at would be great.

Thanks,

Mark Syms
Lead Software Engineer
XenServer Storage
Cambridge, UK
