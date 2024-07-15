Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938C6FC2
	for <gfs2@lists.linux.dev>; Mon, 15 Jul 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057237; cv=none; b=nHX8NEX71bKH7gkT1YivndiGbb8F1rA+Fg0jNsnwJgyP4epocN2556VLVeVa0VPGMMrik0JExKICdQwTob3YakjfnWu7x69O0/OOWBbOlYawb7bMLHGRgJGiXHgcUywqfXaJDsq3NIHMPyfKdndTe//qfPf9bnd5j0b05uPOng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057237; c=relaxed/simple;
	bh=2S+FrgQ8ryPuwWYvWnP1efip7b8Y99QYBtp9UmFAWAQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=genCcZ5hSW3JBNymEw750fd2Rg2P1v0E31gX3BUOCX+3jsGOmuOqgLPNnWOwxPvTHuOPeQeXHo59R2eg2N5hMl39SmuQ0g7vPgQxFrRWJclMldbPf7g2KxF5xMvPxnJvEUDN0bVXteAJ2NBpuFbHsTCTAkrP4STOmcauE6Tla6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sqfg6PrF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sqfg6PrF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721057235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=2S+FrgQ8ryPuwWYvWnP1efip7b8Y99QYBtp9UmFAWAQ=;
	b=Sqfg6PrFG5tsQKh6VNKkMHnoeBS/RjGyIsR+TdcN/J9sutTvcnnPUb8z1TW99Q4cl5uiQo
	CFfGu4Mok3mrRTX7nom5dbKyUJGD8Mf0w4hR/bjGZgBGqiWXLZzaRKj47n3yjab5NMRlca
	OIwbM2fs2ttTQz07ws6k/2qYILJgbDc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-fJXnwuZcPLKWnHuhXJahpw-1; Mon, 15 Jul 2024 11:27:13 -0400
X-MC-Unique: fJXnwuZcPLKWnHuhXJahpw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ee8d83db53so46644101fa.1
        for <gfs2@lists.linux.dev>; Mon, 15 Jul 2024 08:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721057232; x=1721662032;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2S+FrgQ8ryPuwWYvWnP1efip7b8Y99QYBtp9UmFAWAQ=;
        b=rh8mmKQcoC25Da1/3UvA4Sr5ERmzsZF5boypn2M3SYdxn43HysXpQPJpOYztCh/ZlF
         hWp8oaIB0hnsrDo2BWcmtAQzQ2EnCMNLuwYZNLwBMpOKaBSxh6+c+Or0YN/2/AOj3Y9b
         nUGMFevdfVEOP3PngpbSNYFbdlvT2KA0Ooiz8W7wFb0ls6a4zUEZuiHabBdEJTRYU335
         eBFhjg6HSOW8ZCyVOFYA5/EmgFlPJ04mBHZw1qe+XQ2d2OXq9vwWsdlH+/HzXFHomOsf
         g7lx7jK89oZX+6qD0YI9GPHxlZhcu2V+yeHSf0jOBevp4DZaFhLeLsb34EmPWviHpba/
         G4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOy0azET1ZktF+1ziir0bEIBfpEQmtYsj0dABcJAcXeTIFT9AfPZ8HqnxTlpbF5vnvqkDhAboa7rmV3KdKnMRwoVYruQ==
X-Gm-Message-State: AOJu0YwafLv6CjvxtmVAsElMtQ8Eg5drpcXJWCdWZVM/Pq6/1PoFv18K
	NEgGIfy4YSPefpIUrgzrDK6F7HanLJsuRMksdx9KWXTTumMQKRExLV71pBG3bo5qNSaRGfsUwuM
	2VwV0E9VhpN8zx/VJNMTabr/rTUEA67LchXJV/HHgH1gpYMPuUx6I3LScEmOv0Rl/NkQumTNbta
	MEGUe/khXQi8qP+XtJr3B6WIZDoQ==
X-Received: by 2002:a2e:b6d2:0:b0:2ec:a022:880c with SMTP id 38308e7fff4ca-2eef2d7b300mr2044441fa.22.1721057232313;
        Mon, 15 Jul 2024 08:27:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/cAGXKgNc1G6xQ5YWBwDINp5NWcOG2InrNWSxqlV2YNKQjwSCAOCz7jjWvd/r6Ah19T2H7Sct5RkMKoTvo6U=
X-Received: by 2002:a2e:b6d2:0:b0:2ec:a022:880c with SMTP id
 38308e7fff4ca-2eef2d7b300mr2044291fa.22.1721057231912; Mon, 15 Jul 2024
 08:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 15 Jul 2024 11:27:00 -0400
Message-ID: <CAK-6q+jSBjuFaFqGLQcfVLMUwRcJJMHk2oUnSgMObwz+OAih6g@mail.gmail.com>
Subject: udev kset_create_and_add() with own struct kobj_type?
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gfs2 <gfs2@lists.linux.dev>, 
	David Teigland <teigland@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I am currently implementing namespace support into the fs/dlm
subsystem. The DLM subsystem uses kset_create_and_add("dlm",
&dlm_uevent_ops, kernel_kobj); to create the "dlm" sysfs directory.
Underneath it creates for each lockspace a subdirectory using
kobject_init_and_add() with a non-static name and being known during
runtime.

Now I want to add namespace support and need to change the "default"
kset->kobj.ktype = &kset_ktype; that is set by
kset_create_and_add()->kset_create() to my own kobj_type because I
need to implement a different ".child_ns_type" callback before
kset_register() is called.

So kset_create_and_add() does not allow me to add my own
".child_ns_type" callback for the kset that is required for me to have
my sysfs "kernel/dlm" directory separated by each net-namespace
without breaking any backwards compatibility.

My current solution is that I mostly copy&pasted the code of
kset_create_and_add()/kset_create() to have a way to tell my own
struct kobj_type that contains the implemented my own ".child_ns_type"
callback.

I am writing this mail to get some advice on what I can do here
without doing the copy&pasted code?
Add a parameter to kset_create_and_add() that allows me to set an
"struct kobj_type"?
Introducing a new function that does allow me to set the new parameter
(I probably like that because then I don't need to update all other
users)?

Thanks in advance for any advice.

- Alex

