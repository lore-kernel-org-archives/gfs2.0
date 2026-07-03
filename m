Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97DB1A3AB0
	for <gfs2@lists.linux.dev>; Fri,  3 Jul 2026 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079152; cv=none; b=AdoYUQ0PSi2W3TapFx711rXZym0dXiyXJbVfbEHUETSkkWvwVvbPzxC9yFkEobuzRjkQ5o5+j+CmHY6LeHB1rE7wk1EQFyrzIAVxD70fFBCox2/7m8kvN2Bx1QF+BLGFhTA++WEmrT+3FN1jYRUDCV/fP4nQDQ6guhCE8HH+tGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079152; c=relaxed/simple;
	bh=GeUDSjrHAWkuRRsR++4INezbx04TBh6B1L1rO/GgWvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tn1UfLcJcf1mms2svVQGs1VeE72KWetzcBORpyyer0DUS95fwo5E7/wtuzHykQKza8n1cgJ6q7jFELFmsC8RgLaTRC92lYkzW8yZyymFyy80jfFSbi7P9cUlVnuV1vS4JeuOGj5fC2BaHNF/lhujZ5uDzQvDQZYdCoTIu9gJIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLyBr8UH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLyBr8UH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783079150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GeUDSjrHAWkuRRsR++4INezbx04TBh6B1L1rO/GgWvo=;
	b=fLyBr8UHrSEqg9mX1jWuNKlo7oMOf4wjm4nQy29h5hs9u9Q2mYus9sOv08VUwyflg3FS1m
	eLvdaR6OqWFv67rXVtlEvgWjTVCPX2CRI5vXnVRrfC2LzJalZNr69iFMeLwg90Oe7TmAh9
	WPB6CmlvLK7W5vcSlNnmyZhSUQvl3bk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-A4_6ZKc_P527_rVt0nPDuA-1; Fri, 03 Jul 2026 07:45:49 -0400
X-MC-Unique: A4_6ZKc_P527_rVt0nPDuA-1
X-Mimecast-MFC-AGG-ID: A4_6ZKc_P527_rVt0nPDuA_1783079149
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-808a9e51918so12604827b3.2
        for <gfs2@lists.linux.dev>; Fri, 03 Jul 2026 04:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079148; x=1783683948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeUDSjrHAWkuRRsR++4INezbx04TBh6B1L1rO/GgWvo=;
        b=NmcnswFPth4P/b4WcXUWgEI7aKXEgWY4e4FKiXiwR3/6ste15cgGjBv91MtPYELXlG
         fE5m+2a7o7hBAQADHnpKqNO0vTESeGzdjGD/sf3b99NsHq+PtWO5XhiWse5VvrvxMtbg
         S+bwqnTdkfEhJ44MRLHP9oAbu2o8IaoxjXEEHz+MHnHhDH/qBy/cbgCrSHakjxfhVoZ/
         0Eaq49EI7qdIkShourngW3pWJvlsrZbJndTVPYB/8ug/DiwEdYyl23/BCrD61/lBPRW3
         vviRQnxhM0j1ods/kMc+7YgmvDJh5MLJD7qdDobjULmeOuPkc/DZpLsSSsDNZYApf9cJ
         t47A==
X-Forwarded-Encrypted: i=1; AHgh+Rq380YqGv7KvU1AAvu9iQPw2fZLMh75m4JZBI4s/CXgHq+nkxuhvoH3eKITL2o3lHqjy+Jg@lists.linux.dev
X-Gm-Message-State: AOJu0YzmoXWH2XrP3kRAz266V+erydMS+G5J/OckI9YQcMA2S7HxY6WL
	gV+Qk/mGiYtgOJGxKJCrqdYyLQpJ0arKzGoGoYzwnBCww5Tm27NVUx9RC5uJJ84HbKOXpV0tblM
	dy479oxi2RbOV5+DPCFE5g0YkCXD1I5W4pGJDzLEqgrvZAOFnlUghG/N9IvvKcV3l+knlKJNs+G
	N+dvwc1xWIl2o503TB/4mH3miEyNHOOQ==
X-Gm-Gg: AfdE7clMKL0ZX7Z2AflHRrtvwUwvA1j6zdrYzd048vUct3JmD/5WVFuVm9wM8mue9Qt
	d6DjiKrkbPGKwNo8d3M+fYqwi/CquTXQLMNmXis6qLTGOpNp5F2JbbSNW2G1cOhfknsaFXauqw9
	qpIAcIfqenLu+23Ta+onjfqgi1u/rXt8hvL1XpsWxIFaCzshCQNjYKYpaizm99jBvbxyv6ElmMD
	GRFmqMdBHDRtmBpQzB1qY/6xIU9CI1pFGIuTvwntYYRXoh9eOcFDkQ=
X-Received: by 2002:a05:690c:6e0f:b0:806:1ec8:9626 with SMTP id 00721157ae682-812eae80545mr104664727b3.39.1783079148586;
        Fri, 03 Jul 2026 04:45:48 -0700 (PDT)
X-Received: by 2002:a05:690c:6e0f:b0:806:1ec8:9626 with SMTP id
 00721157ae682-812eae80545mr104664337b3.39.1783079148147; Fri, 03 Jul 2026
 04:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com> <20260701000949.1666714-13-joannelkoong@gmail.com>
In-Reply-To: <20260701000949.1666714-13-joannelkoong@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 3 Jul 2026 13:45:36 +0200
X-Gm-Features: AVVi8CdOnoIEUsSqGG1Lvbx5AQnAbjO-BXv_ely4Zi6OZQFZeWID1WZjNQSTcpA
Message-ID: <CAHc6FU76J-YYRd2B=ZPN2DMabQjkzgG9qSzbP_S1s9AsSJNh=w@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] gfs2: convert iomap ops to ->iomap_next()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@lst.de, djwong@kernel.org, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, 
	"open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mN-LCUHQYA8Vxaj1bhp_bV7K2y5Vfe1MyFp1ZnWkpBg_1783079149
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Joanne,

you say in the cover letter that

>This series is submitted against Christian's vfs iomap tree, and is based
> on top of the current head of his tree (commit f2727952b21d1).

which repository and branch is that? It's not vfs.iomap in
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git; I don't
have a proper merge point.

Thanks,
Andreas

