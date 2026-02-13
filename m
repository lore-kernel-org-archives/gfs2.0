Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9A8C1F
	for <gfs2@lists.linux.dev>; Fri, 13 Feb 2026 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771016605; cv=none; b=tXp0gYu7xDGdHZpze59RSYxB+Afoe5CYdTfQBm4rn2LVKDczUwzJGDSBc8+QlGIx/xIQAp3IiRI/RdoNuLgopt2mf9HZyrTJrLUsSsVMM/x5SUUEUY5X5aXBbipBBAhbWB2MjNgvaQ9+OOvrr0HvCQ7zEM2qaQp+HHN0mQEZBLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771016605; c=relaxed/simple;
	bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uLmtrImwwxabE6rZ6BWKqYSeYEwouHrlTKdQ9BSu/IqM+a7WsMRibQsLbZZzWujO5pmonvjgByfYQMFvoZ9bP9FAL6TAcyIpewe5ySGW6xkpYfr5ZKBFgsv0PtTJ10kPkgd3Icd2EwL52deLwjxaSCe8Bw1h2t0vsO5Iww/llSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuSvRB60; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuSvRB60"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771016603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
	b=HuSvRB60DddThvCOJQnB9DA2U6hpx3kTWtT/D1VVwoFobJ67scD5VzHYgZbxtZfmC0UIuK
	L+ba28dj+0WjDDyH+yxlzMChzHIdcJn9YY/IEffCYYfrxzyHQ9RtDKYz7FzC2cPG/6tUcy
	G31AJ9LE//OeMedRrDeWc6G7LA4LqJc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Ew-890AoNbuNnQP5xmIsYg-1; Fri, 13 Feb 2026 16:03:21 -0500
X-MC-Unique: Ew-890AoNbuNnQP5xmIsYg-1
X-Mimecast-MFC-AGG-ID: Ew-890AoNbuNnQP5xmIsYg_1771016600
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59e16c11f49so1036141e87.0
        for <gfs2@lists.linux.dev>; Fri, 13 Feb 2026 13:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771016600; x=1771621400;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
        b=NVhQmD6l0F3i6ZOX5oUxcPXXT9W3UudG0QOLLJajGilx53nBJY6xCQyopgDT1TzFvt
         PSu9CB4/aIlpITKmUUjzPbNksrk7Qokpp/TAP3UuJYGFDpKuvMcmHsuJV3mSkjBnfckN
         eNyfZupZhMFA14DePzR0sPZwJ+uNJ0w8QFxEYNc9Rvm7bddFNaGom2v98tBbjtCbzD+c
         L4GuPJ1+OTZoA3vGBTM8nOjT9iC7zGmaZNWIQg6Fv1CDBCFfOM6qArjvS/9kxFrKKt0+
         XQg12TgLSb7NylvcAIhG8XL2CtXrOLp168Y2/KhR66PgPru2lwzBk7WBbabEx4r89ioB
         tIHw==
X-Forwarded-Encrypted: i=1; AJvYcCX6k3snq66eEGa2kP4Y0DBd6h6XPe48zh5VVPfUopyxT5dBG/0j5X2wzEnsLOHpU1gOd6Qr@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6uIq8LAZ2wOmuQxRa5ct9tXC0Qtzdmqa54YaSDYtyISmgwnMr
	nt7l41S3Drqm7XAf1R6ag9bnuHeCrubQVZHfaa6g6xfiWS4DIytuD+WKgs/co0bDe3GP+Anl3EZ
	4boACcsaIY9AdW4lqHnJCdzi1g1xVWOouS4+on6hMvZfA7CPzj60QXFkRrsJFiM2MvQxeinPW54
	EAHcLmaVVLMWkk/CrmAv87SwFM/SWnbQ==
X-Gm-Gg: AZuq6aLLj61Vz0AvB2eOSadyfecS8KjiRXWCRz38KCUqWWX67tF9x/TR9mcQvuJUxqu
	QT/C9madAxC6Nr5qHYq8KLWJF/PWYbH6/mjZZEC2wcL2fFCfxvf29mSVObh9UGtJDcKIfh8K6qG
	8A1NM7jUHoxW7DsUxU/anSW3yElwZTmCgWwqGeZI/2+G/mMGK/hc6p4cSK0gSpQZYKlVjjckY9e
	MMxg8Qf2ocqiNXHaBtUtAemROE+J7ioowKv6M7P
X-Received: by 2002:a05:6512:32c3:b0:59e:46c6:9081 with SMTP id 2adb3069b0e04-59f6d34c80dmr210939e87.2.1771016600012;
        Fri, 13 Feb 2026 13:03:20 -0800 (PST)
X-Received: by 2002:a05:6512:32c3:b0:59e:46c6:9081 with SMTP id
 2adb3069b0e04-59f6d34c80dmr210929e87.2.1771016599486; Fri, 13 Feb 2026
 13:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 13 Feb 2026 16:03:08 -0500
X-Gm-Features: AZwV_QgZDC4BMfr_62OBKQIGw1rPOpj8cinGnFyTwRxTcGMVGoVWq9ZzvvqAjuA
Message-ID: <CAK-6q+gVhsKKPPax52nju8HXPApPyO9zE_jUygDxvhF8BT8P9Q@mail.gmail.com>
Subject: [LSF/MM ATTEND] distributed file locking
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-nfs <linux-nfs@vger.kernel.org>, 
	gfs2 <gfs2@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NGK8ViLrxOzf8kKJNeXyUIDoLn4a4-D5cWbm4LeC9Wc_1771016600
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi,

this proposal for LSF/MM aims to start an initial process to discuss
improving the distributed file locking API in file_operations.
Initially the file locking API, used from the user space via flock()
or fcntl(), was not designed for distributed locking. There are known
issues e.g. specifying a process id but missing additional information
about the distributed entity where the process is running.

There should be a way for users to opt into additional distributed
locking extensions that provide specific distributed locking info or
even introduce a new file ops distributed locking API. Designing such
new behaviour requires community effort to become aware of all
distributed locking use cases in the Linux kernel. Examples of those
users include DLM, NFS or CIFS.

A recent proposal [0] suggested offering the file locking API only to
the user through a virtual filesystem, using DLM as the distributed
lock manager backend for now. The filesystem's concept can be extended
to offer other backends and allow experiments with new "distributed"
file locking API extensions until the community agrees on and proposes
a stable API.

This proposal discusses an exotic and very specific topic: distributed
file locking, which tries to map to the existing file locking API.
Users working on distributed file systems are aware of the challenges
involved. Solving those long-standing challenges will be a lengthy
process. It might be time to start improving this situation.

Please feel free to share your thoughts on this topic.

- Alex

[0] https://lore.kernel.org/linux-fsdevel/20260213180014.614646-1-aahringo@redhat.com

