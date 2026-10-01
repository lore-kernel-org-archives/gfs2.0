Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6413CCFCC
	for <gfs2@lists.linux.dev>; Thu,  1 Oct 2026 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896287; cv=none; b=iV9jmIvtL7WFmoRilRzLb1pAOVKcNgFaQRVmGdNG7b2nU98ANJgqU7t/ffAsJjnqgK2F5FmEav/1uHrmo9oT1ldzDwqFYZaCTDFFvS0zuRRrU/7J9kgqk5KN1trtVX88mNscmci0ug5eZXYOaMN/BrlD3Mq8E21XRn55BF2TW9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896287; c=relaxed/simple;
	bh=4Nb1L9U4YfwNkyfWFRjbEZ8/q2Pq0SGn9d6+3u74spM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzBvYIe6D0+sXFAWRy4CcH939+m45tl2MqegKw1Q9CPGpy1hhNJbjufHLNefcTbCZK6JhAwWvVGtfX7aZJHDCbyV4dhoRosDI6p5DdlGBkHjGpiK7Rrk4aYfWLCY3CZxdBaa7u+CZAYYkeZCarooltD7mFZCwCZawAOSOaJOngM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xt1B567I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt1B567I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790896282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Nb1L9U4YfwNkyfWFRjbEZ8/q2Pq0SGn9d6+3u74spM=;
	b=Xt1B567Ij8yNv3xYfWogjK+OHHVGH6fIgBx2dISAgzVbyN/lsOEwxS0H8DdlaqfWLJT1Ga
	V7wChZEM01wjON1FkeXLnY/C6QGkLmi7+sgUOOkYY7rOFU7+pX/LvU+Q7MGsqYyogU2H26
	k0MGrEmuc3MiePZczGd1cLDi72mfFXc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-zD7-olNiMv-XogIL7Zv-gg-1; Thu, 01 Oct 2026 19:11:21 -0400
X-MC-Unique: zD7-olNiMv-XogIL7Zv-gg-1
X-Mimecast-MFC-AGG-ID: zD7-olNiMv-XogIL7Zv-gg_1790896280
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3a782da8ce7so8938741fa.2
        for <gfs2@lists.linux.dev>; Thu, 01 Oct 2026 16:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790896280; x=1791501080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Nb1L9U4YfwNkyfWFRjbEZ8/q2Pq0SGn9d6+3u74spM=;
        b=wtkFH6MCaEH7MaTZt1AJaOeq0V09q3RHa0zgATV3D9pr/l3RdMtInTGrTVNuk0WguH
         E+C2jecp8kOQ/6xOWAgUlkDRrbdbnGrWfYG4eijEMmzqzHZPg8lGFuSQq7dsPPhe0kbW
         UdEL1GMF7T55Bqbx0jLa0kc49qZehtME7GeWdErYTE43QL06Vyo3+/1CbTc1zdr7KDOP
         1CNN+//zoMDNpPDbRqW9aSzWOfmKWhwJZ8BegCVPMrbNzofMHkNIm3G9c84t7O7HT/Dr
         EgFLKi/X1cncIO7rsct5Z3GpIcsf1eal5KgjU8cs/Sf5hMSIZG/gM4MnuaMpOJgEAgSO
         k+3w==
X-Forwarded-Encrypted: i=1; AKwUvBxR2nuEMVaTc6CKdj5LJgvBA6FU5GId2++nmyU7G1M9H4F4Xsa2cPGmHR2oyD+k6ycsJXSh@lists.linux.dev
X-Gm-Message-State: AFq9FYKVWuEtsRPdZl88ywbPtmAU9773iDYp+vwKkCnFcL9R0Hdp2lna
	qWHzCAsDQeDNgTs8SJmggVaukW5OQbPkGttKmGJ12DDLonqcxeKGyQecW6bs5Ou2lAMLmVIRwcx
	ggKBr6WHwNPP7UxLfTmbpMxg5PsLyKj24ZcymI/FjDBJ2e7iTZy80V71k/qssHiegg3rU9uXhSH
	illBwdzc7vDD+6koj60yrHP5jOQWiwcA==
X-Gm-Gg: AYBFou2Fdt9Oc/1RZVIzv2YGTrGckFZFuRpIHi3WS1ADfIf4uDuh5K6MvBQnVTbMM1L
	uIa1FSyL1tNVzLB5hH9jj/jnuu6D9mvQEoBmRRxe1uGwRgOrQMKYYt5aRN13cUmW/uVejvVDvPi
	wg7hbjBnHouEuvmQACfbHhEq7FlJpyl1ZuSdV3v1NlXbQE93wsTTXRJBlw
X-Received: by 2002:a2e:8a9c:0:b0:3a7:8294:caac with SMTP id 38308e7fff4ca-3a8828d995fmr1606191fa.3.1790896279770;
        Thu, 01 Oct 2026 16:11:19 -0700 (PDT)
X-Received: by 2002:a2e:8a9c:0:b0:3a7:8294:caac with SMTP id
 38308e7fff4ca-3a8828d995fmr1606171fa.3.1790896279429; Thu, 01 Oct 2026
 16:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ar4BZ26gjQEjZgIa@stanley.mountain>
In-Reply-To: <ar4BZ26gjQEjZgIa@stanley.mountain>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 1 Oct 2026 19:11:08 -0400
X-Gm-Features: AclHuK_ZIZU9AoOcMzsszikhvoplml_bm1WdOkYBM7Pkh36bT-GWQFKoCy-TOGc
Message-ID: <CAK-6q+is-tnpfGqiNCj-SyHYAKfe4ZYQH15=c_rqOy7pkgCoTw@mail.gmail.com>
Subject: Re: [PATCH] dlm: clean up a type in waiters_read()
To: Dan Carpenter <error27@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LK8Y8ec6dQbo6-oSbs287QPGfXwTg99O4FKxRpWK7V4_1790896280
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 1, 2026 at 2:45=E2=80=AFAM Dan Carpenter <error27@gmail.com> wr=
ote:
>
> This doesn't affect runtime but "rv" stores error codes and so
> declare it as ssize_t instead of size_t.
>
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

