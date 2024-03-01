Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13619747C
	for <gfs2@lists.linux.dev>; Fri,  1 Mar 2024 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313832; cv=none; b=f4nla1vOgBa0gQSTIZSMKXW4w/67CdH9Wmea6ygfJVNO/ooGst+NLZt3OELx9yF1YmGxsLHaHubzaz6iI0ZeTMPGBYaywvFVPwGzc/RQOjiAEb6xQFMbfyTEoXfYtmo/5Um4EKi+jW80Qg0CtUd8AtqGmBB7Bedvbxl7HjL49L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313832; c=relaxed/simple;
	bh=eRgfzvzaN9/xz35A2ljdoqGrcDYBfNk7WB8vetaTg8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPTa0KnJs4K7tf9pV0heyTUAJ+d+MlFRpZThKdzMD9gZjFt5zB0LWWjm9PxuhFLDNs92U1ipu6BSwcmFkS6SQCeY2NSLcaLu66bUU+77os8JstFtmzIdpJUXh5tFF+oV2yPmP1Ju/GR78if/WQM5ggbo6XAjfbfNNEsNkmKQpWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+ScjVzi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+ScjVzi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709313830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuLM8IJ5z3YlcIErAZnFpk03cyM9Ac+jxHCCUMFLp7E=;
	b=c+ScjVziX7M3vyyJWOkj4WXbllRWPc4B14izwx7gWQYczWVqpND8QE6szWyNwbEYFjrfQB
	SiZC438wGabnrnzMNDu/+MNzocbgoKlUELMOi3LNxYD5OAaRlFbpHA2Nyg2zygdeZ3zzvI
	X8OO3Z+DUtyQl6ORCtQyQhxS80bzsVw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-tzWelkzjPJaXTz1hDBFvXA-1; Fri, 01 Mar 2024 12:23:48 -0500
X-MC-Unique: tzWelkzjPJaXTz1hDBFvXA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d2a53cb0bbso13828041fa.0
        for <gfs2@lists.linux.dev>; Fri, 01 Mar 2024 09:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313827; x=1709918627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuLM8IJ5z3YlcIErAZnFpk03cyM9Ac+jxHCCUMFLp7E=;
        b=HVWyx38PpyFoWxomsaE2c4/kEcMYigmpC+lbdRtZcgEAx6171M1OqfYygOqwsjV73M
         v4MSC8OMXETqlJRQ/c0bZ2xX4Z4ProwgL9slwlFNJ0W8kv8C60mBttb5Robetp/jgnAc
         LRZdmo05SZioLftSIwWDRK1D+X8VG2XQTP12MVQhqqV3ZH6F81LOnZCRBq8eUsIVQSah
         X0lY8pyyyVdvtv3us9ww65h5f4eQ1ALUPKLnNAoNbwPZmo79CuK/Xcf3Qjxc3yo9kKa7
         hbF02j7t+rbF3ctQFh7UdJvvMjZ1Gv7yrgnOOjRPQv4YyQk6jj/pU9gIb4oF1pa7KPH6
         Afew==
X-Forwarded-Encrypted: i=1; AJvYcCWkmJK4rkx2EqQmC5ZfjJfUux00AGK9dHEiWMEUPKCToKvOh5+Ac1CVQ23SbN7QhLCzmUBwOARQh13Rgk0Hamkzg2rcyw==
X-Gm-Message-State: AOJu0YzUwyFOxB8YiyZiy5nluViBk/AJKilY8y6EORDaZbGnhfn0xMOS
	sIvmfdutQWw59pmrXG4IyPx8Qc9F7t+kyUcyt5ayi8qiW/BAdS2Ln1+0vjoARCNqNiwQyfXHM0F
	v1MVMMzSQ2vngyico8/1OzHs+G/0Lokh4jX1hC/xRIVoOr+Jvtr4R7IG/Ri5Tma5W8LdkdAwrd8
	yDq9IYOwWTlajhsyp4PJwOeVaKgw==
X-Received: by 2002:a2e:b80e:0:b0:2d2:536c:3e35 with SMTP id u14-20020a2eb80e000000b002d2536c3e35mr864994ljo.26.1709313827149;
        Fri, 01 Mar 2024 09:23:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLyJ95wrAe1CW21Jqg7HL324Gs9OGU+JMENNQ17PdzWe/iZFOtV8pqRg6iEnO7HDx0RGBpPxmti25/HSTnap4=
X-Received: by 2002:a2e:b80e:0:b0:2d2:536c:3e35 with SMTP id
 u14-20020a2eb80e000000b002d2536c3e35mr864985ljo.26.1709313826790; Fri, 01 Mar
 2024 09:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230925201827.1703857-1-aahringo@redhat.com> <20240209052631.wfbjveicfosubwns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAH2r5msWwX7QdXrzmR3tapU85WMga9Y-waNOHm+hMWmWPUF=tQ@mail.gmail.com>
 <20240209114310.c4ny2dptikr24wx5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240301103835.gylf2lzud2azgvx7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAK-6q+jZVfK2=Z6RCCU+K+TLYuHgC4ynqOBz3K-nhcypCoN3ww@mail.gmail.com> <a5eb6c3a2de1b959117d49c436b81904@manguebit.com>
In-Reply-To: <a5eb6c3a2de1b959117d49c436b81904@manguebit.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 1 Mar 2024 12:23:35 -0500
Message-ID: <CAK-6q+isU4cQN6OV_bLmoKwULsisAUpkAZA+c6SRgOCk8Z9T=g@mail.gmail.com>
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
To: Paulo Alcantara <pc@manguebit.com>
Cc: Zorro Lang <zlang@kernel.org>, Zorro Lang <zlang@redhat.com>, 
	Steve French <smfrench@gmail.com>, fstests@vger.kernel.org, gfs2@lists.linux.dev, 
	jlayton@kernel.org, linux-cifs@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 1, 2024 at 11:25=E2=80=AFAM Paulo Alcantara <pc@manguebit.com> =
wrote:
>
> Hi Zorro,
>
> The problem is that cifs.ko is returning -EACCES from fcntl(2) called
> in do_test_equal_file_lock() but it is expecting -EAGAIN to be
> returned, so it hangs in wait4(2):
>
> ...
> [pid 14846] fcntl(3, F_SETLK, {l_type=3DF_WRLCK, l_whence=3DSEEK_SET, l_s=
tart=3D0, l_len=3D1}) =3D -1 EACCES (Permission denied)
> [pid 14846] wait4(-1,
>
> The man page says:
>
>       F_SETLK (struct flock *)
>               Acquire a lock (when l_type is F_RDLCK or F_WRLCK) or relea=
se  a
>               lock  (when  l_type  is  F_UNLCK)  on the bytes specified b=
y the
>               l_whence, l_start, and l_len fields of lock.  If  a  confli=
cting
>               lock  is  held by another process, this call returns -1 and=
 sets
>               errno to EACCES or EAGAIN.  (The error  returned  in  this =
 case
>               differs across implementations, so POSIX requires a portabl=
e ap=E2=80=90
>               plication to check for both errors.)
>
> so fcntl_lock_corner_tests should also handle -EACCES.
>

yes, that is a bug in the test but in my opinion there is still an
issue. The mentioned fcntl(F_SETLK) above is just a sanity check to
print out if something is not correct and it will print out that
something is not correct and fails.

The problem is that wait() below, the child processes are not
returning and are in a blocking state which should not be the case.

What the test is doing is the following:

parent:

1. lock(A) # should be successful to acquire

child:
thread0:
2. lock(A) # should block
thread1:
3. lock(A) # should block

parent:

5. sleep(3) #wait until child are in blocking state of lock(A)

5. unlock(A) # both threads of the child should unlock and exit
...
6. sleep 3 # wait for pending unlock op (not really sure if it's necessary)
...
7. trylock(A) # mentioned sanity check
8. wait(NULL) # wait for child to exit

The unlock(A) should unblock the child threads, it is important to
mention that this test does a lock corner test and the lock(A) in both
threads ends in a ->lock() call with a "struct file_lock" that has
mostly the same fields. We had issues with that in gfs2 and a lookup
function to find the right request with an async complete handler of
the lock operation.

- Alex

