Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA4F41D63B
	for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226440; cv=none; b=PUkS/uDMnl4Kfaen2hnp7spO0Vk56pyJYQF2PbCOrYHIuNBLKrQ1RZMgpLvn9jDManWUt9lp4QJ/jnwSRT4qOLVvRXXTmQ0KhOR0/Wnc1B177uOnNuFjXvtqEpjDqcl0ZUIUkhmovLklb8NozJmkZ21a2FOPZlnZnncZRFVSVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226440; c=relaxed/simple;
	bh=6Frx+VtepRSKW1rrt8xYqPsfMnm846XbrFk9qmncxYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZVU2xdEddDXbCgqAm/grL7L65+ACxWwA41LtVj9ZiGcDz7WMkhEsdc5ZvLl3MxJruGQVUAQo1QgXvPYgQeBmlsut0s8FcPOXPh5+LY9eHNpJ3FckwsfEe2xxnDmKO2i3pWVrcg9WansZJQ0npyYqAekYVsgFNsZgfbcQo0xvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fC/eXaaF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fC/eXaaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784226437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Frx+VtepRSKW1rrt8xYqPsfMnm846XbrFk9qmncxYs=;
	b=fC/eXaaFfEy02AG6rjbPvgunzxOBGGvBpZht7G+PszMXHfRbg0VOI3QtI1OLuu0AzqBEp7
	+gDUZRtGxFgsg8p3HARELLvYgADYW8l7jRm8J/1SVaru9C7P0EgaMDMybidSFYVe10GHSh
	sn6qTqlpTwbw21YPXdofFacGFak+fdQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-KpzhKJP4NF6fpcblbY4PZQ-1; Thu, 16 Jul 2026 14:27:16 -0400
X-MC-Unique: KpzhKJP4NF6fpcblbY4PZQ-1
X-Mimecast-MFC-AGG-ID: KpzhKJP4NF6fpcblbY4PZQ_1784226435
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-39ad467f184so37641741fa.2
        for <gfs2@lists.linux.dev>; Thu, 16 Jul 2026 11:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226435; x=1784831235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Frx+VtepRSKW1rrt8xYqPsfMnm846XbrFk9qmncxYs=;
        b=ZQ/TleqQz2OX6MKr8WTxs+qjBylzfhQEPfzL+vQkNIcdnuWDmMaXi3TpitcbD6ex59
         k7s4SchJTo0oUQeJWJwu1qX3kOjJk/XQ5hrOoZVw7aZhrty9dMqtGpNA+Zw0jCGBa2hO
         S4WzEcY6jdJLewHPG889V4p2YlgXTbmgaZX2hC8MXM6k3g+HzWOXpmjEXj/ZLI+r1IgL
         vuD8dk2o9lWhuC22UFkdoVcLscqJbSWRsYeyijWBimZBXPRlQh0Jk/q0SbHYwPTyoJUP
         8HVDtbc6nGA5Ry9fbtIiSH4sYAKJkH+Dz637kltCFXvx2SPl01npiQYUHLp53VcyYX4n
         YSsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZz1cfUhJcOZhXXlWU6LIOGA/RnKkiaLo/m2UMnBrdAni+jg4k6urjBboqmlaMB0rOrd+K@lists.linux.dev
X-Gm-Message-State: AOJu0YwvncFRgWajW6fm4cDhvTYeZDn6F5xz4PWln7YQQjRp4CXO7pNV
	EEevR30cTI4eXHtacREX7aNw7nGXa4kw1wtjJdWaRtN3jw851rP3sA/JHY5ikGNFXhW+UiU+sZi
	qpXsI8GvC51JSPwbQF/Ybg3nQRaSYXCIQp8sGSsrr/19iZeQ3aRin/GIqpb2h+qpxkdsp/ZPHnw
	JRerpRHPy/7JqwRGKSBhc8+cXBrJlBpQ==
X-Gm-Gg: AfdE7clgODjd7yU2vbRGzW0mmkeOK3cdE93+VU35AoWMX0DlS55knnQBuqcpdutB2yt
	zLTuTn4ywApREZ7RLsaF7km6SS+d77hCXds2jkOB1Za+WJv42R2mFA6PM0PPhMdKw21xh+Gmc6t
	lScRaLHnGRT1J5oQy3XMANnR+NNoWAdu4aZog1MxyaXRUcP+6CDe3+WyZi7jnKgWTB0/lV4wBWL
	ShwmbOEUrNnnm3F
X-Received: by 2002:a2e:b895:0:b0:39b:a2c:bc6e with SMTP id 38308e7fff4ca-39db6d92c1fmr19373541fa.34.1784226434821;
        Thu, 16 Jul 2026 11:27:14 -0700 (PDT)
X-Received: by 2002:a2e:b895:0:b0:39b:a2c:bc6e with SMTP id
 38308e7fff4ca-39db6d92c1fmr19373471fa.34.1784226434359; Thu, 16 Jul 2026
 11:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260517020315.1064253-1-joseph.qi@linux.alibaba.com> <CAK-6q+jvaQx6y_tOzks3utBWaTRjvVnDWrznBYRfWjTQBcefBA@mail.gmail.com>
In-Reply-To: <CAK-6q+jvaQx6y_tOzks3utBWaTRjvVnDWrznBYRfWjTQBcefBA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 16 Jul 2026 14:27:02 -0400
X-Gm-Features: AUfX_mxRMsqoGVD2QKe-mn6QvJqDwQG4q7UB5CE2EHSrqjB-nt8V6M81rAHXDBU
Message-ID: <CAK-6q+j4bGf4s59b49QQu1yDi13vXwwrxt9JzPGApm8zf=nVMw@mail.gmail.com>
Subject: Re: [PATCH v2] dlm: fix buffer overflow from negative len in dlm_search_rsb_tree
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1mu2PR5MSVhYKwf-_U4X45IsvljZydPTxtVJBWKs9D4_1784226435
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 25, 2026 at 10:27=E2=80=AFAM Alexander Aring <aahringo@redhat.c=
om> wrote:
>
> Hi,
>
> On Sat, May 16, 2026 at 10:03=E2=80=AFPM Joseph Qi <joseph.qi@linux.aliba=
ba.com> wrote:
> >
> > commit 080e5563f878 only checks for len > DLM_RESNAME_MAXLEN, which doe=
s
>
> check with checkpath, it reports an error regarding how this commit
> reference is done.

I fixed your commit message for this patch; checkpatch requires a very
specific commit reference style here.
It's "commit 080e5563f878c ("dlm: validate length in dlm_search_rsb_tree")"=
.

- Alex

