Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AD39C628
	for <gfs2@lists.linux.dev>; Tue,  3 Feb 2026 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112884; cv=none; b=AXTKclY5ugXVnWfwq8EEmnXz+/yfZA8GTJ9yUh7ZHhUknJbChNZJgojDm8W65Vvxai45wjdL8z2mHTOfYw+7VAJTQmfpzN3+Na5AkkbmNyQHKzEyF0tg+OXwfARDKl8b9iYF+kRoiMXWQmkoQuy/QR9R167CYngjoNyMsaxuqSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112884; c=relaxed/simple;
	bh=luMj+cN6DA+ZzNE4sxMRzn44i9lzPj+N6pkqqIEpOzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/jvXx215i1GAgOgq/I78WcXoQGCpXdOmSKspnNwAaVWwU1dkm8lagI01lgNYLThisd8zrpRAz+TWxs0GUpRLSnOnggclWiEO+fhamJY6447M+HMhnacKzGAixtFiIZGcHcuZxqfncrR8/mZzhBzy8I9q9KSUzb3YJGt7ycaY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dz91hD4p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz91hD4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770112880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=luMj+cN6DA+ZzNE4sxMRzn44i9lzPj+N6pkqqIEpOzg=;
	b=Dz91hD4pBfPuQ6xsn0duKFvwv6az6UgF8Jzex7CAsj/Hb9WhzslHO/w+BvAgYNyYIdEr/U
	syF7srzJIPdb9tfI8oK/mKsBKCj5vh2lyYY7CTGLygQlGmQuoWlxGTjqZQ75JJVKWir8os
	X62kbUo0BmfLk3obF54J1hgDODfgDCg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-cUgXXhBGOwWkZC2L_DqJmg-1; Tue, 03 Feb 2026 05:01:18 -0500
X-MC-Unique: cUgXXhBGOwWkZC2L_DqJmg-1
X-Mimecast-MFC-AGG-ID: cUgXXhBGOwWkZC2L_DqJmg_1770112878
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7942395ecc1so73533087b3.3
        for <gfs2@lists.linux.dev>; Tue, 03 Feb 2026 02:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112878; x=1770717678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luMj+cN6DA+ZzNE4sxMRzn44i9lzPj+N6pkqqIEpOzg=;
        b=Ed7+OmGXovYXHW0yae18/ydN77VnvMRtsHYY65eflnKmc2Hv504HVnss/9a5J6z9GL
         lr+hBkanXQKqbbyE5lf5yL64fMonhF//bD8rjRI4zZG7eLZmXX5zS7zwk9AewQEtMcuY
         ZXXgAQlP1+Ds4hnl8KCl6SXN3k45xYF9tk4T+CokCQCtJmubXmpbvawOUK9jnc/hxzYR
         aImLSjLRb6VkbOLRV74uHyChqTWMePV/fNMlLP0vvxmkh/rUgmM753fQT3xWTIyn4RpL
         kUnpABvqA3LSr/kkQVdOYOO0G1YhIt+AzSFbyL95td3qQo0nJuTPQm4oYeg4z6cJMpRr
         aa4A==
X-Gm-Message-State: AOJu0Yzu9f7Z37ZE5eQwRLvkirNmxKsoNU/NMrb/AcpvCOlT//d5srBE
	DdJ71buGFac6XY61gnldz+wdD2Zk/N1Mt+7tx0fE5xCFLJRyz4pC2B8wK2De3Wx8byggINKPgHl
	W3qW5dksfQ6nT0G1bSr+iXB6S4BRJAJxxRvWL5eUmUebHb5GdPc1F8w7at907vjtwFOOIwZAGzp
	UVHIgkJO7eTa6B5bn7ghuErAhOz+GhLKO1wA5HRVYX
X-Gm-Gg: AZuq6aIOrO13q02fM22ODnkjDacAbj/4IM4UxVn1ajQ5cTaD6ISQ3LWSphDgZIC6DkR
	dWmoFlZptqBEg8M9duuMTquVGZXg5Ww9OE0khhelUry+kiwNyK7N3Srjp/klxOLg5ztWOqoA6AU
	MhHwnYCzFDLJYy4tFK7SZfMjWa2DHUWzUNgPNU/KGVPxlqWIAsc66cTPC6r0WvoCrdjVrrnFjDC
	f88GngxJpfg8tCCa2FvylJC2zSiZHFAEFA0s3ZKBwmEJYQZ9t6utA==
X-Received: by 2002:a05:690e:128d:b0:649:51d8:6f72 with SMTP id 956f58d0204a3-649a84363ccmr11275258d50.5.1770112878094;
        Tue, 03 Feb 2026 02:01:18 -0800 (PST)
X-Received: by 2002:a05:690e:128d:b0:649:51d8:6f72 with SMTP id
 956f58d0204a3-649a84363ccmr11275233d50.5.1770112877593; Tue, 03 Feb 2026
 02:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <697cbeda.050a0220.142e72.0000.GAE@google.com>
In-Reply-To: <697cbeda.050a0220.142e72.0000.GAE@google.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 3 Feb 2026 11:01:06 +0100
X-Gm-Features: AZwV_QjD6BwGBXxm4wLNhIFdzVBIo0vokkqKu6CoBM7muPh9CUnlr-UPJBV2MHU
Message-ID: <CAHc6FU6rnwZoq4_OqT9wo-G0anrtLkOcdO=WdP6JAJf6Yhx90A@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] memory leak in __kthread_create_on_node
To: syzbot <syzbot+aac438d7a1c44071e04b@syzkaller.appspotmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KRt0UtJKc1kHPB3hlkkhSU4MgF0_G_p24JAVtp12FLk_1770112878
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
for-next

